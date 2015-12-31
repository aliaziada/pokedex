//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Alia Ziada on 12/30/15.
//  Copyright © 2015 Ntime. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalizedString
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        pokedexLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    func updateUI(){
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        attackLbl.text = pokemon.attack
        evoLbl.text = pokemon.nextEvolutionTxt
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        if pokemon.nextEvolutionId != "" {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
        }else{
            evoLbl.text = "No Evolution"
            nextEvoImg.hidden = true
        }
    }
    @IBAction func onBackTapped(btn: UIButton!){
        dismissViewControllerAnimated(true, completion: nil)
    }
}
