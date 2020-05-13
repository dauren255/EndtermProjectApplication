//
//  MusicVideoResponse.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 5/6/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit

struct MusicVideo : Codable {
    let strTrack: String
    let strTrackThumb: String!
    let strMusicVid: String!
    let strDescriptionEN: String!
}

struct MusicVideoResponse: Codable {
    let mvids: [MusicVideo]
}
