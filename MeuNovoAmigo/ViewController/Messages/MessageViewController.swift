//
//  MessageViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 02/09/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var chat: Chat? {
        didSet {
            navigationItem.title = chat!.friend
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true;
        
        self.view.backgroundColor = UIColor.white
        
        if let messageView = Bundle.main.loadNibNamed("MessageView", owner: self, options: nil)?.first as? MessageView {
            self.view.addSubview(messageView)
            
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false;

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
