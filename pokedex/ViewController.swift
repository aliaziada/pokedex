//
//  ViewController.swift
//  pokedex
//
//  Created by Alia Ziada on 12/29/15.
//  Copyright © 2015 Ntime. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var musicPlayer : AVAudioPlayer!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon] ()
    
    var searchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        parsePokemonCSV()
        createMusic()
    }
    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let pokeName = row["identifier"]!
                let poke = Pokemon(name: pokeName, pokedexId: pokeId)
                pokemon.append(poke)
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            if searchMode {
                cell.configureCell(filteredPokemon[indexPath.row])
            }else {
                cell.configureCell(pokemon[indexPath.row])
            }
            return cell
        }else{
            return UICollectionViewCell()
        }
        
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    @IBAction func onMusicTapped(sender: UIButton!) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.3
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    func createMusic(){
        let musicPath = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: musicPath))
        }catch let err as NSError{
            print(err.debugDescription)
        }
        musicPlayer.prepareToPlay()
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searchMode = false
            view.endEditing(true)
        }else{
            searchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
        }
        collectionView.reloadData()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

