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
        
        if (self.email.text != "" && self.password.text != ""){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {
                (user, error) in
                if let error = error {
                    print("\n\n\n\n\(error.localizedDescription)\n\n\n\n")
                    return
                }
            print("\n\n\n\n\n\n\(self.email.text, self.password.text)\n\n\n\n\n")

            self.getUser(email: self.email.text!)
                let PetList: UITabBarController = (self.storyboard?.instantiateViewController(withIdentifier: "PetList") as? UITabBarController)!
                self.present(PetList, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Opsss!", message: "Seu email ou a sua senha estão incorretos!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if auth.currentUser != nil {
//                self.getUser(email: (auth.currentUser?.email)!)
//
//                let PetList: UITabBarController = (self.storyboard?.instantiateViewController(withIdentifier: "PetList") as? UITabBarController)!
//                self.present(PetList, animated: true, completion: nil)
//            }
//        }
    }
    func getUser(email: String) {
        print("\n\n\n\(email)\n\n\n")
        
        let ref = Firestore.firestore().collection("users").whereField("email", isEqualTo: email)
        ref.addSnapshotListener(includeMetadataChanges: false) { (Snapshot, Error) in
            if (Error != nil){
                print(Error as Any)
                return
            }
            let user = User(dictionary: (Snapshot?.documents[0].data())!)!
            let info = User.sharedUserInfo()
            info.name = user.name
            info.image = user.image
            info.email = email
            info.id = user.id
            info.city = user.city
            info.birth = user.birth
            info.state = user.state
            info.phoneNumber = user.phoneNumber
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
