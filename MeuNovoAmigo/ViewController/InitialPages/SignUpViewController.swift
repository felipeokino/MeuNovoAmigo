//
//  SignUpViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 10/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

//    @IBOutlet weak var fullName: UITextField!
//    @IBOutlet weak var cpf: UITextField!
//    @IBOutlet weak var city: UITextField!
//    @IBOutlet weak var state: UITextField!
//    @IBOutlet weak var email: UITextField!
//    @IBOutlet weak var password: UITextField!
//    @IBAction func tapSignUp(_ sender: Any) {
//        if let name = self.fullName.text, let cpf = self.cpf.text,let city = self.city.text, let state = self.state.text,let email = self.email.text, let password = self.password.text {
//            let newUser = User(id: "",name: name, cpf: cpf,state: state,city: city,email: email);
//            self.registerUser(newUser: newUser, password: password)
//        }
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func registerUser(newUser: User, password: String) {
//        Auth.auth().createUser(withEmail: newUser.email, password: password, completion: nil)
//        let ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("users").child(newUser.cpf).setValue([
//            "name":newUser.name,
//            "cpf": newUser.cpf,
//            "city": newUser.city,
//            "state": newUser.state,
//            "email": newUser.email,
//            "id": ref.key
//            ])
////        let MainView: UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController)!
////        self.present(MainView, animated: true, completion: nil)
//        let PetList: UITableViewController = (self.storyboard?.instantiateViewController(withIdentifier: "PetList") as? PetsTableViewController)!
//        self.present(PetList, animated: true, completion: nil)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
//    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */

}
