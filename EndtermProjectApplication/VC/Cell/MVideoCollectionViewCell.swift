//
//  MVideoCollectionViewCell.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 5/6/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import AlamofireImage
class MVideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMusicVideo: UIImageView!
    @IBOutlet weak var titleMusicVideo: UILabel!
    func configureCell(musicVideo: MusicVideo){
        imageMusicVideo.layer.cornerRadius = 10
        titleMusicVideo.text = musicVideo.strTrack
        if musicVideo.strTrackThumb != "", musicVideo.strTrackThumb != nil {
            imageMusicVideo.af_setImage(withURL: URL(string: musicVideo.strTrackThumb)!)
        }
    }
}
