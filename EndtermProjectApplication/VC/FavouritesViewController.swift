//
//  FavouritesViewController.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 5/6/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import FirebaseAuth
class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    private let manager = ArtistManager()
    var artists = [Artists]()
    override func viewDidLoad() {
        super.viewDidLoad()
        artists = manager.getArtists(user: (Auth.auth().currentUser?.email)!)

    }
    override func viewDidAppear(_ animated: Bool) {
        artists = manager.getArtists(user: (Auth.auth().currentUser?.email)!)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell") as! ArtistTableViewCell
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTheFavouriteArtistVCSegue"{
            if let viewController = segue.destination as? ArtistViewController, let index = tableView.indexPathForSelectedRow?.row {
                viewController.artists = artists[index]
            }
        }
    }
}
