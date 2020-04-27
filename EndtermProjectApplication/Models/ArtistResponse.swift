import UIKit

struct Artist : Codable{
    let strArtist: String
    let intBornYear: String!
    let strGenre: String!
    let strWebsite: String!
    let strBiographyEN: String!
    let strArtistThumb: String!
    let strArtistLogo: String!
}

struct ArtistResponse : Codable {
    let artists: [Artist]
}
