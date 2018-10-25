//
//  ChatTableViewController.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 31/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit
import Firebase

class ChatTableViewController: UITableViewController {

    var users:[User] = []
    var chats:[Chat] = []

    @IBAction func showChatController(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false;

//        let user = User(id: "dqwddsadaqw",name: "Felipe Okino", cpf: "123", state: "SP", city: "Sao Carlos", email: (Auth.auth().currentUser?.email)!)
//        users.append(user)
//        
//        self.populateChat()
    }

    func populateChat(){
        var messages : [Message] = []
        var msg : Message!
        msg = Message(fromId: "Eu", toId: "Dunha", modifiedHour: "01/01/2019", content: "Ola")
        messages.append(msg)
        msg = Message(fromId: "Eu", toId: "Dunha", modifiedHour: "01/01/2019", content: "como")
        messages.append(msg)
        msg = Message(fromId: "Eu", toId: "Dunha", modifiedHour: "01/01/2019", content: "vc")
        messages.append(msg)
        msg = Message(fromId: "Eu", toId: "Dunha", modifiedHour: "01/01/2019", content: "esta?")
        messages.append(msg)
        
        let chat = Chat(owner: "Eu", friend: "Dunha", messages: messages)
        chats.append(chat)
    }
//    func observeMessages(){
//        let ref: DatabaseReference!
//        ref = Database.database().reference(withPath: "chats")
//
//        ref.observe(.value, with: { (snapshot) in
//            var messages: [Message] = []
//            for child in snapshot.children {
//                let msg = Message(snapshot: child as! DataSnapshot)
//                if(msg?.friend == ""){
//
//                }
//                messages.append(msg!)
//            }
//            self.chats = messages
//            self.tableView.reloadData()
//        }) { (err) in
//            print("Error " + err.localizedDescription)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat: Chat = chats[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        cell.friendName.text = chat.friend
        cell.friendImage.image = UIImage(named: "perfil")
        cell.lastMessage.text = chat.messages?.last?.content
        cell.modifiedHour.text = chat.messages?.last?.modifiedHour
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chat: Chat = chats[indexPath.row]
//        self.dismiss(animated: true) {
        
            self.showChatLog(chat: chat)
//        }
        
    }

    func showChatLog(chat: Chat) {
        let messagesController = MessageViewController()
        messagesController.chat = chat
        navigationController?.pushViewController(messagesController, animated: true)
//        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
//        chatLogController.chat = chat
//        navigationController?.pushViewController(chatLogController, animated: true)
        
        
    }

    func getAllUsers(){
        let ref: DatabaseReference!
        ref = Database.database().reference().child("users")
        
        ref.observe(.value, with: { (snapshot) in
            var list_users: [User] = []
            for child in snapshot.children {
                guard let user = User(snapshot: child as! DataSnapshot) else {return}
                list_users.append(user)
            }
            self.users = list_users
            self.tableView.reloadData()
        }) { (err) in
            print("Error " + err.localizedDescription)
        }
    }
}
