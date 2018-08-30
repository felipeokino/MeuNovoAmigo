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
            self.registerInFirebase(pet: pet)
        }
    }
    let imagePicker = UIImagePickerController()
    var imageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = originalImage

        } else if let editedImage = info[UIImagePickerControllerEditedImage] {
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

    func registerInFirebase(pet: Pet){
        
        let storageRef = Storage.storage().reference().child("pets/" + self.imageUrl)
        
        if let uploadData = UIImageJPEGRepresentation(self.petImage.image!, 1.0) {
            
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if (error != nil) {
                    print("Deu erro ", error!)
                    return
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if (error != nil){
                        print("And Error Ocurred ", error?.localizedDescription)
                    }
                    let a = url?.absoluteURL.absoluteString
                    self.registerNewPet(imageUrl: a!, pet: pet)
                    print(a)
                })              
                let PetList: UINavigationController = (self.storyboard?.instantiateViewController(withIdentifier: "PetList") as? UINavigationController)!
                self.present(PetList, animated: true, completion: nil)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}
