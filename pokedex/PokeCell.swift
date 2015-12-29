//
//  PokeCell.swift
//  pokedex
//
//  Created by Alia Ziada on 12/29/15.
//  Copyright © 2015 Ntime. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumpImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon : Pokemon!
    
    func configureCell (pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name
        thumpImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
