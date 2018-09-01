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
//        self.tableView.rowHeight = 550
        self.getAllPets()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorInsetReference = .fromAutomaticInsets
        
        let pet: Pet = pets[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetsTableViewCell
        
        cell.petImage.image = UIImage(named: "load")
        cell.petDescription.text = pet.species + " " + pet.description
        cell.address.text = "Rua Costa do Sol 980"
        cell.phoneNumber.text = "(16) 997198406"
        cell.userPhoto.image = #imageLiteral(resourceName: "perfil")
        cell.username.text = "Felipe Okino"

        if let petImageUrl = pet.image {
            let url = URL(string: petImageUrl)
            cell.petImage.kf.setImage(with: url)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
/**
     import Kingfisher
     
     let url = URL(string: "url_of_your_image")
     // this downloads the image asynchronously if it's not cached yet
     imageView.kf.setImage(with: url)
     */

    func getAllPets(){
        let ref: DatabaseReference!
        ref = Database.database().reference(withPath: "pets")
    
        ref.observe(.value, with: { (snapshot) in
            var list_pets: [Pet] = []
            for child in snapshot.children {
                let pet = Pet(snapshot: child as! DataSnapshot)
                list_pets.append(pet!)
            }
            self.pets = list_pets
            self.tableView.reloadData()
        }) { (err) in
            print("Error " + err.localizedDescription)
        }
}
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
     // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
////             Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
////             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
