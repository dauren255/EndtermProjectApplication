//
//  ArtistViewController.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 4/26/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import AlamofireImage
class ArtistViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var biography: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var bornYear: UILabel!
    
    @IBOutlet weak var collectionViewAlbum: UICollectionView!
    
    var artist : Artist!
    var albums = [Album]()
    override func viewDidLoad() {
        NetworkManager.loadAlbums(
            s: artist.strArtist,
        onComplete: { (response) in
            self.albums = response.album
            print(response)
            self.collectionViewAlbum.reloadData()
        }, onError: {
            print("Error")
        })
        setupBg()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionViewAlbum.dataSource = self
        collectionViewAlbum.delegate = self
        collectionViewAlbum.reloadData()
    }
    
    func setupBg(){
        name.text = artist.strArtist
        self.navigationItem.title = artist.strArtist
        if artist.strArtistThumb != nil, artist.strArtistThumb != ""{
            artistImage.af_setImage(withURL: URL(string: artist.strArtistThumb)!)
            artistImage.layer.cornerRadius = 50
        }
        if artist.strBiographyEN != nil, artist.strBiographyEN != ""{
            biography.text = "Biography: " + artist.strBiographyEN
        }
        if artist.strGenre != nil, artist.strGenre != ""{
            genre.text = "Genre: " + artist.strGenre
        }
        if artist.strWebsite != nil, artist.strWebsite != ""{
            website.text = "Website: " + artist.strWebsite
        }
        if artist.intBornYear != nil, artist.intBornYear != ""{
            bornYear.text = "Born year: " + artist.intBornYear
        }
        if artist.strArtistLogo != nil, artist.strArtistLogo != ""{
            logo.af_setImage(withURL: URL(string: artist.strArtistLogo)!)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCollectionViewCell
        cell.configureCell(album: albums[indexPath.row])
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTheAlbumVCSegue"{
            if let indexPath = collectionViewAlbum.indexPathsForSelectedItems?.first {
                let viewController = segue.destination as! AlbumViewController
                viewController.album = albums[indexPath.row]
            }
        }
    }
}
