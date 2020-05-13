import UIKit
import Alamofire

class NetworkManager {

    private static let endpoint = "https://theaudiodb.com/api/v1/json/1/search.php"
    private static let endpointAlbum = "https://theaudiodb.com/api/v1/json/1/searchalbum.php"
    private static let endpointTrack = "https://theaudiodb.com/api/v1/json/1/track.php"
    private static let endpointMusicVideo = "https://theaudiodb.com/api/v1/json/1/mvid.php"

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
            if album == nil {
                onError()
                return
            }
            onComplete(album!)
        }
    }
    
    static func loadTracks(m: Int,
                           onComplete: @escaping (TrackResponse) -> Void,
                           onError: @escaping() -> Void){
        request(endpointTrack, parameters: ["m" : "\(m)"]).responseData { (response) in
            let track = try? JSONDecoder().decode(TrackResponse.self, from: response.data!)
            if track == nil {
                onError()
                return
            }
            onComplete(track!)
        }
    }
    static func loadMusicVideos(i: Int,
                                onComplete: @escaping (MusicVideoResponse) -> Void,
                                onError: @escaping() -> Void){
        request(endpointMusicVideo, parameters: ["i" : "\(i)"]).responseData { (response) in
            let mvids = try? JSONDecoder().decode(MusicVideoResponse.self, from: response.data!)
            if mvids == nil {
                onError()
                return
            }
            onComplete(mvids!)
        }
    }
}
