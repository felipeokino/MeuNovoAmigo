//
//  ContactsTableViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 02/09/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase

class ContactsTableViewController: UITableViewController {

    var contacts: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        observeUsers()
    }

//    func observeUsers() {
//        let ref: DatabaseReference!
//        ref = Database.database().reference(withPath: "users")
//        ref.observe(.value ,with:  { (snapshot) in
////        let contact = User(snapshot: snapshot )
////            tmp_contacts.append(contact!)
//            var tmp_contacts: [User] = []
//
//            for child in snapshot.children {
//                let contact = User(snapshot: child as! DataSnapshot)
//                tmp_contacts.append(contact!)
//            }
//
//            self.contacts = tmp_contacts
//            self.tableView.reloadData()
//        }){ (err) in
//            print("Error " + err.localizedDescription)
//        }
//
//
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = self.contacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        cell.contactEmail.text = contact.email
        cell.contactName.text = contact.name
        cell.imageView?.image = UIImage(named: "empty_user")
        

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
