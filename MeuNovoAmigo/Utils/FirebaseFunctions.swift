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
import FirebaseAuth

class FirebaseUtil {
    init() {
    }
    var db = Firestore.firestore()
    var pets:[Pet] = []

    func registerInFirebase(pet: Pet, imageUrl: String, petImage: UIImageView, _self: UIViewController) {
        let storageRef = Storage.storage().reference().child("pets/" + imageUrl)
        if let uploadData = UIImageJPEGRepresentation(petImage.image!, 0.2){
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if (error != nil) {
                    let alert = UIAlertController(title: "Opsss!", message: "Não conseguimos anunciar seu bichinho! Tente novamente mais tarde.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    _self.present(alert, animated: true)
                    print(error!)
                    return
                } else {
                    storageRef.downloadURL(completion: { (url, error) in
                        if (error != nil){
                            print("An Error Ocurred ", error!)
                        }
                        let a = url?.absoluteURL.absoluteString
                        self.registerNewPet(imageUrl: a!, pet: pet)
                        let alert = UIAlertController(title: "Obaaaa!", message: "O bichinho foi anunciado com sucesso. Logo logo ele terá um novo lar!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aeee", style: .default, handler: { (action) in
                            let PetList: UITabBarController = (_self.storyboard?.instantiateViewController(withIdentifier: "PetList") as? UITabBarController)!
                            _self.present(PetList, animated: true, completion: nil)
                        }))
                        _self.present(alert, animated: true)
                    })
                }
            }
        }
    }
    
    func registerNewPet(imageUrl: String, pet: Pet){
        db.collection("Pets").addDocument(data: [
            "specie":pet.species,
            "image": imageUrl,
            "description": pet.description,
            "owner": Auth.auth().currentUser?.uid as Any,
            ])
    }
    
    func fetchAllPets() -> Array<Pet>{
        db.collection("Pets").whereField("owner", isEqualTo: Auth.auth().currentUser?.uid as Any).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let pet : Pet = Pet(dictionary: document.data())!
                    self.pets.append(pet)
                }
            }
        }
        return pets
    }
    func fetchMyPets() -> Array<Pet>{
        db.collection("Pets").whereField("owner", isEqualTo: Auth.auth().currentUser?.uid as Any).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let pet : Pet = Pet(dictionary: document.data())!
                    self.pets.append(pet)
                }
            }
        }
        return pets
    }
    func getUserEmail() -> String {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.email!
        }
        return ""
    }
    func getUserId() -> String {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        }
        return ""
    }
    
    func getUserName() -> String {
        return "Felipe Okino"
    }
}
