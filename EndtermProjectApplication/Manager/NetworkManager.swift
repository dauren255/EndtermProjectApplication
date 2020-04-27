import UIKit
import Alamofire

class NetworkManager {

    private static let endpoint = "https://theaudiodb.com/api/v1/json/1/search.php"
    private static let endpointAlbum = "https://theaudiodb.com/api/v1/json/1/searchalbum.php"

    static func loadArtists(s: String,
                            onComplete: @escaping (ArtistResponse) -> Void,
                            onError: @escaping() -> Void){
        Alamofire.request(endpoint, parameters: ["s" : s]).responseData { (response) in
            let artist = try? JSONDecoder().decode(ArtistResponse.self, from: response.data!)

            if artist == nil {
                onError()
                return
            }
            onComplete(artist!)
        }
    }
    
    static func loadAlbums(s: String,
                           onComplete: @escaping (AlbumResponse) -> Void,
                           onError: @escaping() -> Void){
        request(endpointAlbum, parameters: ["s" : "\(s)"]).responseData { (response) in
            let album = try? JSONDecoder().decode(AlbumResponse.self, from: response.data!)
            print(response)
            if album == nil {
                onError()
                return
            }
            onComplete(album!)
        }
    }
}
