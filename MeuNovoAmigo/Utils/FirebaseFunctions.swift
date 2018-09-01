//
//  Firebase.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 30/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

public class FirebaseFunctions {
    func RegisterInFirebase(pet: Pet, imageUrl: String, petImage: UIImage) -> Bool{
        let storageRef = Storage.storage().reference().child("pets/" + imageUrl)
        if let uploadData = UIImageJPEGRepresentation(petImage, 1.0) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if (error != nil) {
                    print("Any Error Ocurred ", error!)
                    return
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if (error != nil){
                        print("Any Error Ocurred ", error!)
                    }
                    let a = url?.absoluteURL.absoluteString
                    self.registerNewPet(imageUrl: a!, pet: pet)
                })
                
            }
        }
        return true
    }
    
    private func registerNewPet(imageUrl: String, pet: Pet){
        print(imageUrl)
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("pets").childByAutoId().setValue([
            "specie":pet.species,
            "image": imageUrl,
            "description": pet.description,
            "owner": Auth.auth().currentUser?.uid,
            "flag": "new"
            ])
    }
    
}
