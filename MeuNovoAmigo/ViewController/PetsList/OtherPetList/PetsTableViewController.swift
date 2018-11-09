//
//  PetsTableViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 12/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class PetsTableViewController: UITableViewController {

    var pets: [Pet] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllPets()
        
//        let fireUtil = FirebaseUtil()
//        pets = fireUtil.fetchAllPets()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pet: Pet = pets[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetsTableViewCell
        
        cell.petImage.image = UIImage(named: "load")
        cell.petDescription.text = pet.species + " " + pet.description
        cell.address.text = "Rua Costa do Sol 980"
        cell.phoneNumber.text = "(16) 997198406"
        cell.userPhoto.image = #imageLiteral(resourceName: "perfil")
        cell.username.text = "Felipe Okino"

        if let ownerImageUrl = pet.ownerImage {
            let url = URL(string: ownerImageUrl)
            cell.userPhoto.kf.setImage(with: url)
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
    func getAllPets(){
        let db = Firestore.firestore()
        let books = db.collection("Pets")
        books.addSnapshotListener { (snapshot, Error) in
            if let error = Error {
                print(error.localizedDescription)
                return
            }
            if (snapshot!.documents.count != self.pets.count){
                self.pets = []
                for doc in snapshot!.documents {
                    let pet:Pet = Pet(dictionary: doc.data())!
                    self.pets.append(pet)
                }
            }
            self.tableView.reloadData()
        }
    }
}
