//
//  AlbumViewController.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 4/27/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import AlamofireImage
class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumname: UILabel!
    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var albumArtist: UILabel!
    @IBOutlet weak var albumDescription: UILabel!
    var album : Album!
    var tracks = [Track]()

    override func viewDidLoad() {
        print(album.id)
        super.viewDidLoad()
        albumname.text = album.name
        albumArtist.text = "Artist: " + album.artistName
        if album.imageUrl != nil, album.imageUrl != "" {
            albumImage.af_setImage(withURL: URL(string: album.imageUrl!)!)
            albumImage.layer.cornerRadius = 10

        }
        if album.description != nil, album.description != "" {
            albumDescription.text = "Album description: " + album.description
        }
        tabBarController?.accessibilityElementsHidden = true
        navigationItem.title = album.name
        NetworkManager.loadTracks(m: Int(album!.id)!,
                                  onComplete: { (response) in
                                    print(response.track)
                                    self.tracks = response.track
                                    self.tracksTableView.reloadData()
        }, onError: {
            print("Error Tracks")
        })
        
    }

    override func viewDidAppear(_ animated: Bool) {
        tracksTableView.dataSource = self
        tracksTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as! TrackTableViewCell
        cell.configureCell(track: tracks[indexPath.row], album: album)
        
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
