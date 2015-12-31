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
    private var _nextEvolutionId: Int!
    private var _pokemonUrl: String!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    var description: String{
        return _description
    }
    
    var type: String{
        return _type
    }
    
    var defense: String{
        return _defense
    }
    
    var height: String{
        return _height
    }
    
    var weight: String{
        return _weight
    }
    
    var attack: String{
        return _attack
    }
    
    var nextEvolutionId: Int{
        return _nextEvolutionId
    }
    var nextEvolutionTxt: String{
        return _nextEvolutionTxt
    }
    
    init(name: String,pokedexId: Int){
        _name = name
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)/"
    }
    
    
    func downloadPokemonDetails (complete: DownloadComplete){
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
                print(self._defense)
                print(self._attack)
                print(self._height)
                print(self._weight)
                print(self._type)
            }
            
        }
    }
}