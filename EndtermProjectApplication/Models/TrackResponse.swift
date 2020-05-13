import UIKit

struct Track {
    let id: String
    let name: String
    let duration: String
    
}
extension Track: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idTrack"
        case name = "strTrack"
        case duration = "intDuration"
    }
}

struct TrackResponse: Codable {
    let track: [Track]
}
