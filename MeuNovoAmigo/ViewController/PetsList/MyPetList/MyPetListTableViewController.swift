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
        
//        let fireUtil = FirebaseUtil()
//        pets = fireUtil.fetchAllPets()
        
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
        
        cell.petImage.image = UIImage(named: "load")
        cell.petDescription.text = pet.species + " " + pet.description
        cell.userAdress.text = "Rua Costa do Sol 980"
        cell.userPhone.text = "(16) 997198406"
        cell.userName.text = "Felipe Okino"
        
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
        let books = db.collection("Pets").whereField("owner", isEqualTo: Auth.auth().currentUser?.uid as Any)
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
}
