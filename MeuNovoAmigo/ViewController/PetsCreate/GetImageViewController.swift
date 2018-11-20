//
//  GetImageViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 16/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class GetImageViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var image:String = "load"
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var specie: UITextField!
    @IBOutlet weak var pet_description: UITextView!
    @IBAction func registerPet(_ sender: Any) {

        if let specie = self.specie.text, let petDescription = self.pet_description.text {
            if (specie.count > 0 && petDescription.count > 0 && self.image != "load"){
                let pet = Pet(species: specie, description: petDescription, owner: (Auth.auth().currentUser?.uid)!)
                let fireUtil = FirebaseUtil()
                fireUtil.registerInFirebase(pet: pet, imageUrl: self.imageUrl, petImage: self.petImage, _self: self)
            } else {
                if (self.image == "load"){
                    let alert = UIAlertController(title: "Opsss!", message: "Coloque uma foto do animalzinho!!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else if (specie.count == 0 || petDescription.count == 0){
                    let alert = UIAlertController(title: "Opsss!", message: "Preencha todos os campos!!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    let imagePicker = UIImagePickerController()
    var imageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        petImage.image = UIImage(named: "load")
    }
    @IBAction func GetImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func tapGetImage(_ sender: Any) {
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
            petImage.image = selectedImage
        }
        if let nameImage = info[UIImagePickerControllerImageURL] as? URL {
            let path = nameImage.absoluteString
            let path_array = path.split(separator: "/")
            imageUrl = String(path_array[path_array.count-1])
        }
        self.image = "changed"
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

