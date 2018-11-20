//
//  BasicViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 25/10/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    var userName:String!
    var birthDate:String!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var stateName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Olá, \(userName.components(separatedBy: " ")[0].capitalizingFirstLetter())"
    }
    
    @IBAction func birthPicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        
        let date = dateFormatter.string(from: datePicker.date )
        self.birthDate = date
    }
    
    @IBAction func nextPage(_ sender: Any) {
            if (cityName.text != "" && stateName.text != "" && phoneNumber.text != "") {
                    let ViewController: SignProfileViewController = (self.storyboard?.instantiateViewController(withIdentifier: "imageScreen") as? SignProfileViewController)!
                    
                    ViewController.name = self.userName
                    ViewController.birth = self.birthDate
                    ViewController.city = self.cityName.text
                    ViewController.state = self.stateName.text
                    ViewController.phone = self.phoneNumber.text
                    
                    self.present(ViewController, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Campos Vazios", message: "\(userName.components(separatedBy: " ")[0]), nos conte mais sobre você", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
        }
        
    }
}
