//
//  ChatLogController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 02/09/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate {
    
    var chat: Chat? {
        didSet {
            navigationItem.title = chat?.friend
        }
    }
    
    lazy var inputTextField:UITextField = {
        let inputTextField = UITextField()
        inputTextField.placeholder = "Enter message..."
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.delegate = self
        return inputTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true;
        
        
//        navigationItem.title = "Chat Log"
        
        collectionView?.backgroundColor = UIColor.white
        setupInputComponents()
    }

    func setupInputComponents() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // x,y,w,h
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        // x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputTextField)
        
        // x,y,w,h
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let dividerLineView = UIView()
        dividerLineView.backgroundColor = UIColor.darkGray
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dividerLineView)

        // x,y,w,h
        dividerLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        dividerLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dividerLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    @objc func handleSend() {
        if(inputTextField.text != ""){
            let db = Firestore.firestore()
            let ref = db.collection("chats")
//            let ref = Database.database().reference().child("chat").child("-LMyovKPqNUK-mdgPXku")
            let userId = chat?.friend
            let fromId = Auth.auth().currentUser?.uid
            
            
            let msg = Message(fromId: fromId!, toId: userId!, modifiedHour: "01/01/2019", content: inputTextField.text!)
            chat?.messages?.append(msg)
//            ref.document().setData(chat?.toAnyObject(id: ref.document().documentID) as! [String : Any])
            ref.document().setData(["fromId": chat?.owner, "toId": chat?.friend, "messages": chat?.messages![0]])
            inputTextField.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
}
