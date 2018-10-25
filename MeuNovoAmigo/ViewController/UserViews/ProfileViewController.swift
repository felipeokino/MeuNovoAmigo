//
//  ProfileViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 30/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var imageUrl = ""
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfos()
    }

    func loadInfos() {
        let fireUtils = FirebaseUtil()
        self.profileImage.image = UIImage(named: "empty_user")
        self.userName.text = fireUtils.getUserName()
        self.userEmail.text = fireUtils.getUserEmail()
    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.imagePicker.delegate = self
//        // Do any additional setup after loading the view.
//    }

    @IBAction func logoutBtn(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let ViewController: UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "loginView") as? ViewController)!
            self.present(ViewController, animated: true, completion: nil)
        } catch let error {
            print("Error signing out: \(error)")
        }
        
    }
}
