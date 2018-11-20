//
//  MyPetListTableViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 02/10/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class MyPetListTableViewController: UITableViewController {

    var pets:[Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMyPets()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pet: Pet = pets[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPetCell", for: indexPath) as! MyPetTableViewCell
        let user = User.sharedUserInfo()
        
        cell.petImage.image = UIImage(named: "load")
        cell.petDescription.text = pet.species! + " " + pet.description!
        cell.userAdress.text = user.state
        cell.userPhone.text = "(16) 997198406"
        cell.userName.text = user.name
        
        if let userImageUrl = User.sharedUserInfo().image {
            let url = URL(string: userImageUrl)
            cell.userImage.kf.setImage(with: url)
        }
        
        if let petImageUrl = pet.image {
            let url = URL(string: petImageUrl)
            cell.petImage.kf.setImage(with: url)
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func getMyPets(){
        let db = Firestore.firestore()
        let use = User.sharedUserInfo()
        
        let books = db.collection("Pets").whereField("owner", isEqualTo: use.id as Any).whereField("deleted", isEqualTo: false)
        books.addSnapshotListener { (snapshot, Error) in
            if let error = Error {
                print(error.localizedDescription)
                return
            }
                self.pets = []
                for doc in snapshot!.documents {
                    let pet:Pet = Pet(dictionary: doc.data())!
                        self.pets.append(pet)
                }
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fire = FirebaseUtil()
            let pet = self.pets[indexPath.row]
            fire.deletePet(pet: pet)
        }
    }
}
