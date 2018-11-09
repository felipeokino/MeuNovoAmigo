//
//  ProfileViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 30/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ProfileViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var imageUrl = ""
    var user:User!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInfos()
    }

    func loadInfos() {
        self.userName.text = User.sharedUserInfo().name
        self.userEmail.text = User.sharedUserInfo().email
        
        if let userImage = User.sharedUserInfo().image {
            let url = URL(string: userImage)
            self.profileImage.kf.setImage(with: url)
//            cell.petImage.kf.setImage(with: url)
        }
        print("\n\n\n\(User.sharedUserInfo().name)\n\n\n\n")
        
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
