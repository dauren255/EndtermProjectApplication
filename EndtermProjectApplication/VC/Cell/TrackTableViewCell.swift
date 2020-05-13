//
//  TrackTableViewCell.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 5/5/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import AlamofireImage
class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackDuration: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(track: Track, album: Album){
//        trackCell.layer.cornerRadius = 10
        if album.imageUrl != "", album.imageUrl != nil {
            albumImage.af_setImage(withURL: URL(string: album.imageUrl)!)
            albumImage.layer.cornerRadius = 10
        }
        trackName.text = track.name
        let newDuration = Int(track.duration)! / 1000
        let s: Int = newDuration % 60
        let m: Int = newDuration / 60
        
        let formattedDuration = String(format: "%0d:%02d", m, s)
        trackDuration.text = formattedDuration
    }
}
