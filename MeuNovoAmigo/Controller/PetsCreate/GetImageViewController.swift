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


    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var specie: UITextField!
    @IBOutlet weak var pet_description: UITextView!
    @IBAction func registerPet(_ sender: Any) {
        if let specie = self.specie.text, let petDescription = self.pet_description.text {
            
            let pet = Pet(species: specie, description: petDescription, owner: (Auth.auth().currentUser?.uid)!)
//            self.registerInFirebase(pet: pet)
            _ = FirebaseFunctions()
            self.registerInFirebase(pet: pet)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let imagePicker = UIImagePickerController()
    var imageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        // Do any additional setup after loading the view.
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
//        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            selectedImage = originalImage
//
//        } else
            if let editedImage = info[UIImagePickerControllerEditedImage] {
            selectedImage = editedImage as? UIImage
        }
        guard (selectedImage?.jpeg(.medium)) != nil else {return}
        
        if let selectedImage = selectedImage {
            petImage.image = selectedImage
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
    
    func registerInFirebase(pet: Pet){
        
        let storageRef = Storage.storage().reference().child("pets/" + self.imageUrl)
        
        if let uploadData = UIImageJPEGRepresentation(self.petImage.image!, 1.0) {
            
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if (error != nil) {
                    let alert = UIAlertController(title: "Opsss!", message: "Não conseguimos anunciar seu bichinho! Tente novamente mais tarde.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ta bom vai...", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if (error != nil){
                        print("And Error Ocurred ", error?.localizedDescription)
                    }
                    let a = url?.absoluteURL.absoluteString
                    self.registerNewPet(imageUrl: a!, pet: pet)
                })
                let PetList: UINavigationController = (self.storyboard?.instantiateViewController(withIdentifier: "PetList") as? UINavigationController)!
                self.present(PetList, animated: true, completion: nil)
                let alert = UIAlertController(title: "Obaaaa!", message: "O bichinho foi anunciado com sucesso. Logo logo ele terá um novo lar!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aeeeee", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
        }
    }
    
    private func registerNewPet(imageUrl: String, pet: Pet){
        print(imageUrl)
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("pets").childByAutoId().setValue([
            "specie":pet.species,
            "image": imageUrl,
            "description": pet.description,
            "owner": Auth.auth().currentUser?.uid,
            "flag": "new"
            ])
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}

