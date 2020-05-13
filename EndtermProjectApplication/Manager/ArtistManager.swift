//
//  ArtistManager.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 5/9/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth

class ArtistManager {

    private func getAppDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private func getManagedContext() -> NSManagedObjectContext{
        return getAppDelegate().persistentContainer.viewContext
    }
    
    private func getItemEntity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Artists", in: getManagedContext())!
    }
    
    private func getFetchRequest() -> NSFetchRequest<NSManagedObject> {
        return NSFetchRequest<NSManagedObject>(entityName: "Artists")
    }
    
    func addArtist(artist: Artist){
        let artists = NSManagedObject(entity: getItemEntity(), insertInto: getManagedContext())
        artists.setValue(artist.strArtist, forKey: "name")
        artists.setValue(artist.intBornYear, forKey: "bornYear")
        artists.setValue(artist.strGenre, forKey: "genre")
        artists.setValue(artist.strWebsite, forKey: "website")
        artists.setValue(artist.strBiographyEN, forKey: "biography")
        artists.setValue(artist.strArtistThumb, forKey: "photo")
        artists.setValue(artist.strArtistLogo, forKey: "logo")
        artists.setValue(Auth.auth().currentUser?.email, forKey: "user")

        do {
            try getManagedContext().save()
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        
    }
    func getArtists() -> [Artists]{
        do {
            return try getManagedContext().fetch(getFetchRequest())as! [Artists]
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return []
    }
    func getArtists(user: String) -> [Artists] {
        do {
            let fetchRequest = getFetchRequest()
            let userpredicate = NSPredicate(format: "user = %@", Auth.auth().currentUser?.email as! CVarArg)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userpredicate])
            let artists = try getManagedContext().fetch(fetchRequest) as! [Artists]
            
            if artists.isEmpty {
                return []
            }
            return artists
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return []
    }
    
    func getArtist(name: String, user: String) -> Artists? {
        do {
            let fetchRequest = getFetchRequest()
            let userpredicate = NSPredicate(format: "user = %@", Auth.auth().currentUser?.email as! CVarArg)
            let artistpredicate = NSPredicate(format: "name = %@", name)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userpredicate, artistpredicate])
            let artists = try getManagedContext().fetch(fetchRequest) as! [Artists]
            
            if artists.isEmpty {
                return nil
            }
            return artists[0]
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        return nil
    }
    
    func deleteArtist(user: String, artistname: String){
        do{
            let fetchRequest = getFetchRequest()
            let userpredicate = NSPredicate(format: "user = %@", Auth.auth().currentUser?.email as! CVarArg)
            let artistpredicate = NSPredicate(format: "name = %@", artistname)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userpredicate, artistpredicate])
            let artists = try getManagedContext().fetch(fetchRequest)as! [Artists]
            
            if artists.isEmpty {
                return
            }
            let artist = artists[0]
            getManagedContext().delete(artist)
            try getManagedContext().save()
        } catch let error as NSError{
            print("\(error.userInfo)")
        }
    }
}
