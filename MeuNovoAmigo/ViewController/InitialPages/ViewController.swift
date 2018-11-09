//
//  ViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 05/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//
import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func didTapLogin(_ sender: Any) {
        if let email = self.email.text, let password = self.password.text{
            Auth.auth().signIn(withEmail: email, password: password) {
                (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.getUser()
                let PetList: UITabBarController = (self.storyboard?.instantiateViewController(withIdentifier: "PetList") as? UITabBarController)!
                self.present(PetList, animated: true, completion: nil)
            }
        } else {
            print("senha incorreta")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.getUser()

                let PetList: UITabBarController = (self.storyboard?.instantiateViewController(withIdentifier: "PetList") as? UITabBarController)!
                self.present(PetList, animated: true, completion: nil)
            }
        }
    }
    func getUser() {
        let ref = Firestore.firestore().collection("users")
        ref.addSnapshotListener(includeMetadataChanges: false) { (Snapshot, Error) in
            if (Error != nil){
                print(Error as Any)
                return
            }
            let user = User(dictionary: (Snapshot?.documents[0].data())!)!
            let test = User.sharedUserInfo()
            test.name = user.name
            test.image = user.image
            test.email = user.email
            
            print("\n\n\(test)\n\n")
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
