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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var artistTableView: UITableView!
    @IBOutlet weak var favourites: UIBarButtonItem!
     
    var artists = [Artist]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        if Auth.auth().currentUser == nil{
//            navigationItem.rightBarButtonItem = nil
//        }

//        Auth.auth().signIn(withEmail: "dauren@gmail.com", password: "dauren"){
//            (result, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            print("SIGN IN")
//
//        }
        searchField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        NetworkManager.loadArtists(
            s: searchField.text!,
        onComplete: { (response) in
            self.artists = response.artists
            self.artistTableView.reloadData()
        }, onError: {
            print("Error")
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        artistTableView.dataSource = self
        artistTableView.delegate = self
        artistTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTheArtistVCSegue"{
            if let viewController = segue.destination as? ArtistViewController, let index = artistTableView.indexPathForSelectedRow?.row {
                viewController.artist = artists[index]
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArtistTableViewCell
        cell.configureCell(artist: artists[indexPath.row])
        
        cell.layer.cornerRadius = 10
        let shadowPath2 = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath2.cgPath
        return cell
    }
    
    private func textFieldDidBeginEditing(textField: UITextField) {
        artistTableView.reloadData()
    }

}

