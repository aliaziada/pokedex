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
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
    }
    
    @IBAction func onBackTapped(btn: UIButton!){
        dismissViewControllerAnimated(true, completion: nil)
    }
}
