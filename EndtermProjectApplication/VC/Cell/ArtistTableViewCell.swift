//
//  ArtistTableViewCell.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 4/26/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import AlamofireImage

class ArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(artist: Artist){
        viewCell.layer.cornerRadius = 10
        if artist.strArtistThumb != "", artist.strArtistThumb != nil {
            artistImage.af_setImage(withURL: URL(string: artist.strArtistThumb)!)
            artistImage.layer.cornerRadius = 10
        }
        artistName.text = artist.strArtist
    }

    func configureCell(artist: Artists){
        viewCell.layer.cornerRadius = 10
        if artist.photo != "", artist.photo != nil {
            artistImage.af_setImage(withURL: URL(string: artist.photo!)!)
            artistImage.layer.cornerRadius = 10
        }
        artistName.text = artist.name
    }
}
