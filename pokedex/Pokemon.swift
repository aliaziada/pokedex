//
//  Pokemon.swift
//  pokedex
//
//  Created by Alia Ziada on 12/29/15.
//  Copyright © 2015 Ntime. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _pokemonUrl: String!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionId: String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    var nextEvolutionTxt: String{
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    init(name: String,pokedexId: Int){
        _name = name
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)/"
    }
    
    
    func downloadPokemonDetails (completed: DownloadComplete){
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result.value
            if let dect = result  as? Dictionary<String,AnyObject> {
                if let weight = dect["weight"] as? String {
                    self._weight = weight
                }
                if let height = dect["height"] as? String {
                    self._height = height
                }
                if let attack = dect["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dect["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dect["types"] as? [Dictionary<String,String>] where types.count > 0{
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    if types.count > 1 {
                        for var i = 1;i < types.count; i++ {
                            if let name = types[i]["name"]?.capitalizedString {
                                self._type! += "/\(name)"
                            }
                        }
                    }
                }else {
                    self._type = ""
                }
                
                if let descArr = dect["descriptions"] as? [Dictionary<String,String>] where descArr.count > 0{
                    if let descUrl = descArr[0]["resource_uri"] {
                        let url = NSURL(string: "\(URL_BASE)\(descUrl)")!
                        Alamofire.request(.GET, url).responseJSON { descResponse in
                            let descResult = descResponse.result.value
                            if let descDect = descResult as? Dictionary<String,AnyObject> {
                                if let desc = descDect["description"] as? String {
                                    self._description = desc
                                }
                            }
                            completed()
                        }
                        
                    }else{
                        self._description = ""
                    }
                    if let evolution = dect["evolutions"] as? [Dictionary<String,AnyObject>] where evolution.count > 0{
                        if let evolutionTxt = evolution[0]["to"] as? String {
                            if evolutionTxt.rangeOfString("mega") == nil{
                                if let evolutionLvl = evolution[0]["level"] as? Int {
                                    self._nextEvolutionTxt = "Next Evaluation: \(evolutionTxt) LVL \(evolutionLvl)"
                                    if let uri = evolution[0]["resource_uri"] as? String {
                                        let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                        let id = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                        self._nextEvolutionId = id
                                    }
                                }
                            }
                        }
                    }else{
                        self._nextEvolutionTxt = ""
                        self._nextEvolutionId = ""
                    }
                }
            }
            
        }
    }
}