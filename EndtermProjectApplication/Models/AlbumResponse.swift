import UIKit

struct Album {
    let id: String
    let name: String
    let artistName: String
    let description: String!
    let genre: String!
    let year: String!
    let imageUrl: String!
}

extension Album: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idAlbum"
        case name = "strAlbum"
        case description = "strDescriptionEN"
        case artistName = "strArtist"
        case genre = "strGenre"
        case year = "intYearReleased"
        case imageUrl = "strAlbumThumb"
    }
}

struct AlbumResponse: Codable {
    let album: [Album]
}
