//
//  ArtistViewController.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 4/26/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.


import UIKit
import FirebaseAuth
import AlamofireImage
class ArtistViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var favourite: UIBarButtonItem!
    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var biography: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var bornYear: UILabel!
    
    @IBOutlet weak var collectionViewAlbum: UICollectionView!
    @IBOutlet weak var collectionViewMusicVideos: UICollectionView!
    
    var artist : Artist!
    var artists : Artists!

    var albums = [Album]()
    var mvideos = [MusicVideo]()
    private let manager = ArtistManager()
    override func viewDidLoad() {
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.rightBarButtonItem = favourite
        if Auth.auth().currentUser == nil {
            navigationItem.rightBarButtonItem = nil
        } else {
            if artists != nil {
                if (manager.getArtist(name: artists.name!, user: (Auth.auth().currentUser?.email)!)) != nil{
                    favourite.image = Image(systemName: "heart.fill")
                }
            } else {
                if (manager.getArtist(name: artist.strArtist, user: (Auth.auth().currentUser?.email)!)) != nil{
                    favourite.image = Image(systemName: "heart.fill")
                }
            }
        }
        if artist != nil {
            setupBgForArtist()
        } else if artists != nil {
            setupBgForArtists()
        }
        super.viewDidLoad()
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        collectionViewAlbum.dataSource = self
        collectionViewAlbum.delegate = self
        collectionViewMusicVideos.dataSource = self
        collectionViewMusicVideos.delegate = self
    }
    
    func setupBgForArtist(){
        NetworkManager.loadAlbums(
            s: artist.strArtist,
        onComplete: { (response) in
            self.albums = response.album
            self.collectionViewAlbum.reloadData()
        }, onError: {
            print("Error Albums")
        })
        NetworkManager.loadMusicVideos(
            i: Int(artist.idArtist)!,
        onComplete: { (response) in
            self.mvideos = response.mvids
            self.collectionViewMusicVideos.reloadData()
        }, onError: {
            print("Error MusicVideos")
        })
        name.text = artist.strArtist
        self.navigationItem.title = artist.strArtist
        if artist.strArtistThumb != nil, artist.strArtistThumb != ""{
            artistImage.layer.cornerRadius = 10
            artistImage.af_setImage(withURL: URL(string: artist.strArtistThumb)!)
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
    func setupBgForArtists(){
        name.text = artists.name
        self.navigationItem.title = artists.name
        if artists.photo != nil, artists.photo != ""{
            artistImage.layer.cornerRadius = 10
            artistImage.af_setImage(withURL: URL(string: artists.photo!)!)
        }
        if artists.biography != nil, artists.biography != ""{
            biography.text = "Biography: " + artists.biography!
        }
        if artists.genre != nil, artists.genre != ""{
            genre.text = "Genre: " + artists.genre!
        }
        if artists.website != nil, artists.website != ""{
            website.text = "Website: " + artists.website!
        }
        if artists.bornYear != nil, artists.bornYear != ""{
            bornYear.text = "Born year: " + artists.bornYear!
        }
        if artists.logo != nil, artists.logo != ""{
            logo.af_setImage(withURL: URL(string: artists.logo!)!)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewAlbum {
            return albums.count
        } else {
            return mvideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if collectionView == collectionViewAlbum {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCollectionViewCell
            cell.configureCell(album: albums[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicVideoCell", for: indexPath) as! MVideoCollectionViewCell
            cell.configureCell(musicVideo: mvideos[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewMusicVideos{
            UIApplication.shared.open(URL(string: mvideos[indexPath.row].strMusicVid)!, options: [:])
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTheAlbumVCSegue"{
            if let indexPath = collectionViewAlbum.indexPathsForSelectedItems?.first {
                let viewController = segue.destination as! AlbumViewController
                viewController.album = albums[indexPath.row]
            }
        }
    }
    @IBAction func favouriteFire(_ sender: Any) {
        if favourite.image == Image(systemName: "heart.fill") {
            if artists != nil {
                manager.deleteArtist(user: (Auth.auth().currentUser?.email)!, artistname: artists.name!)
            } else {
                manager.deleteArtist(user: (Auth.auth().currentUser?.email)!, artistname: artist.strArtist)
            }
            favourite.image = Image(systemName: "heart")
        } else {
            manager.addArtist(artist: artist)
            favourite.image = Image(systemName: "heart.fill")
        }
    }
}
