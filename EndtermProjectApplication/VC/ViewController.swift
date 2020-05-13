//
//  ViewController.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 4/25/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import FirebaseAuth
import AlamofireImage
import Alamofire

class ViewController: UIViewController{
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var artistTableView: UITableView!
    private let manager = ArtistManager()

    var artists = [Artist]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func signOut() -> Bool{
        do{
            try Auth.auth().signOut()
            return true
        }catch{
            return false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        artistTableView.dataSource = self
        artistTableView.delegate = self
        artistTableView.reloadData()
        searchField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTheArtistVCSegue"{
            if let viewController = segue.destination as? ArtistViewController, let index = artistTableView.indexPathForSelectedRow?.row {
                viewController.artist = artists[index]
            }
        }
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArtistTableViewCell
        cell.configureCell(artist: artists[indexPath.row])
        
        cell.layer.cornerRadius = 5
        let shadowPath2 = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath2.cgPath
        return cell
    }
}
extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkManager.loadArtists(
            s: searchField.text!,
            onComplete: { (response) in
                self.artists = response.artists
                self.artistTableView.reloadData()
        }, onError: {
            print("Error Artists")
        })
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        NetworkManager.loadArtists(
            s: searchField.text!,
            onComplete: { (response) in
                self.artists = response.artists
                self.artistTableView.reloadData()
        }, onError: {
            print("Error Artists")
        })
        view.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchField.text = ""
        view.endEditing(true)
    }
}

