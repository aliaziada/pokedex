//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Alia Ziada on 12/30/15.
//  Copyright © 2015 Ntime. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pokemon.name)
    }
}
