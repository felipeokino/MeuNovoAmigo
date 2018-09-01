//
//  message.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 31/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import Foundation
import Firebase

class Message {
    let owner: String
    let friend: String
    var modifiedHour: String?
    var messages: Array<String>?
    
    init(owner: String, friend: String, modifiedHour: String?) {
        self.owner = owner
        self.friend = friend
        self.modifiedHour = modifiedHour
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let owner = value["owner"] as? String,
            let friend = value["friend"] as? String,
            let messages = value["messages"] as? String,
            let modifiedHour = value["modifiedHour"] as? String else {return nil}
        self.owner = owner
        self.friend = friend
        self.modifiedHour = modifiedHour
        self.messages = [messages]
    }
    
    func toAnyObject() -> Any {
        return [
            "owner": owner,
            "friend": friend,
            "modifiedHour": modifiedHour
        ]
    }
}
