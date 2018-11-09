//
//  WelcomeViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 25/10/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var fullName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func nextPage(_ sender: Any) {
        if (fullName.text != "") {
            if let name = fullName.text {
                let ViewController: BasicViewController = (self.storyboard?.instantiateViewController(withIdentifier: "basicInfoScreen") as? BasicViewController)!
                ViewController.userName = name
                self.present(ViewController, animated: true, completion: nil)
            }
        }else {
            let alert = UIAlertController(title: "Campos Vazios", message: "Poxa, nos conte o seu nome", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
