//
//  ResetViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 10/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase

class ResetViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBAction func resetPassword(_ sender: Any) {
        if let email = self.email.text {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let alert = UIAlertController(title: "Redefinir senha", message: "Um link foi enviado ao seu email para redefinir a sua senha", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    print("Send Message to your mailbox")
                }
                
        }
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
