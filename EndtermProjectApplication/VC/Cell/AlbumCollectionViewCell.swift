//
//  AlbumCollectionViewCell.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 4/26/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import AlamofireImage
class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumYear: UILabel!


    func configureCell(album: Album){
        albumImage.layer.cornerRadius = 10
        albumName.text = album.name
        if album.year != "", album.year != nil {
            albumYear.text = album.year
        }
        if album.imageUrl != "", album.imageUrl != nil {
            albumImage.af_setImage(withURL: URL(string: album.imageUrl)!)
        }    }
}
