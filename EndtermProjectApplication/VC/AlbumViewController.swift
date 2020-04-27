//
//  AlbumViewController.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 4/27/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import AlamofireImage
class AlbumViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumname: UILabel!
    var album : Album!
    @IBOutlet weak var albumArtist: UILabel!
    @IBOutlet weak var albumDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        albumname.text = album.name
        albumArtist.text = "Artist: " + album.artistName
        if album.imageUrl != nil, album.imageUrl != "" {
            albumImage.af_setImage(withURL: URL(string: album.imageUrl!)!)
        }
        if album.description != nil, album.description != "" {
            albumDescription.text = "Album description: " + album.description
        }
    }

}
