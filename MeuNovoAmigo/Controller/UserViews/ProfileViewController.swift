//
//  ProfileViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 30/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var imageUrl = ""
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfos()
    }

    func loadInfos() {
        self.ProfileImage.image = UIImage(named: "empty_user")
        self.username.text = "Felipe Okino"
        self.userDescription.text = "Graduação em Análise e Desenvolvimento de Sistemas"
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

}
