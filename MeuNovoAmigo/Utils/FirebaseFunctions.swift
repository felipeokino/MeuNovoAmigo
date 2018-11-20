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
        let user = User.sharedUserInfo()
        let ref = db.collection("Pets").document()
        ref.setData(
            [
                "specie":pet.species as Any,
                "image": imageUrl,
                "description": pet.description as Any,
                "owner": user.id as Any,
                "ownerImage": User.sharedUserInfo().image!,
                "ownerName": User.sharedUserInfo().name!,
                "ownerCity": User.sharedUserInfo().city!,
                "ownerState": User.sharedUserInfo().state!,
                "ownerPhone": User.sharedUserInfo().phoneNumber!,
                "id": ref.documentID,
                "deleted": false
            ])
    }
    
    func deletePet(pet: Pet){
        db.collection("Pets").document(pet.id!).delete()
//        ref.setData(["deleted": true])
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
    
    func registerUserInFirebase(user: [String: Any], imageUrl: String, userImage: UIImageView, _self: UIViewController) {
        
        let storageRef = Storage.storage().reference().child("profile/" + imageUrl)
        
        if let uploadData = UIImageJPEGRepresentation(userImage.image!, 0.2){
            
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                
                if (error != nil) {
                    let alert = UIAlertController(title: "Opsss!", message: "Não conseguimos te cadastrar! Tente novamente mais tarde.", preferredStyle: .alert)
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
                        
                        self.registerNewUser(imageUrl: a!, user: user)
                        
                        let alert = UIAlertController(title: "Olaaaa!", message: "Bem vindo à nossa comunidade!", preferredStyle: .alert)
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
    
    func registerNewUser(imageUrl: String, user: [String: Any]){
        let ref = db.collection("users").document()
        
        ref.setData([
            "name": user["name"] as Any,
            "birth": user["birth"] as Any,
            "city": user["city"] as Any,
            "state": user["state"] as Any,
            "image": imageUrl,
            "email": user["email"] as Any,
            "id": ref.documentID
        ])
    }
}
