//
//  message.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 31/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import Foundation
import Firebase

class Chat {
    var id: String?
    let owner: String
    let friend: String
    var messages: Array<Message>?
    
    init(owner: String, friend: String, messages: [Message]) {
        self.owner = owner
        self.friend = friend
        self.messages = messages
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let id = value["id"] as? String,
            let owner = value["fromId"] as? String,
            let friend = value["toId"] as? String,
            let messages = value["messages"] as? Array<Message>
            else {return nil}
        self.id = id
        self.owner = owner
        self.friend = friend
        self.messages = messages
    }
    
    func toAnyObject(id: String) -> Any {
        return [
            "id": id,
            "owner": owner,
            "friend": friend,
        ]
    }
}
