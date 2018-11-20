//
//  signProfileViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 25/10/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase

class SignProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    var name:String!
    var birth:String!
    var city:String!
    var state:String!
    var phone:String!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let imagePicker = UIImagePickerController()
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.text = "\(name.components(separatedBy: " ")[0].capitalizingFirstLetter()),"
        userImage.layer.cornerRadius = 75
        userImage.clipsToBounds = true
        
        userImage.image = UIImage(named: "load");
    }
    
    @IBAction func selectImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        if let editedImage = info[UIImagePickerControllerEditedImage] {
            selectedImage = editedImage as? UIImage
        }
        if let selectedImage = selectedImage {
            userImage.image = selectedImage
        }
        if let nameImage = info[UIImagePickerControllerImageURL] as? URL {
            let path = nameImage.absoluteString
            let path_array = path.split(separator: "/")
            imageUrl = String(path_array[path_array.count-1])
        }
        dismiss(animated: true, completion: nil)
    }
    
    // funcao que encerra o teclado quando clicar em qualquer area externa
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func register(_ sender: Any) {
        self.registerUser()
    }
    
    func registerUser() {
        if (email.text != "" && password.text != ""){
             let fireUtil = FirebaseUtil()
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (res, Error) in
                if (Error != nil){
                    let alert = UIAlertController(title: "Opsss!", message: "Erro ao realizar o seu cadastro, tente novamente mais tarde", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                let user = ["name": self.name, "birth": self.birth, "state": self.state
                    , "city": self.city, "email": self.email.text!, "phoneNumber": self.phone] as [String : Any]
                
                fireUtil.registerUserInFirebase(user: user as [String : Any], imageUrl: self.imageUrl, userImage: self.userImage, _self: self)
            }
        } else {
            let alert = UIAlertController(title: "Opsss!", message: "Nos conte o seu email e escreva uma senha =(", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
