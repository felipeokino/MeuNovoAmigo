//
//  message.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 21/09/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import Foundation
import Firebase

class Message {
    let fromId: String
    let toId: String
    var modifiedHour: String?
    let content: String
    
    init(fromId: String, toId: String, modifiedHour: String?, content: String) {
        self.fromId = fromId
        self.toId = toId
        self.modifiedHour = modifiedHour
        self.content = content
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let fromId = value["fromId"] as? String,
            let toId = value["toId"] as? String,
            let content = value["text"] as? String,
            let modifiedHour = value["timestamp"] as? String else {return nil}
        self.fromId = fromId
        self.toId = toId
        self.modifiedHour = modifiedHour
        self.content = content
    }
    
    func toAnyObject() -> Any {
        return [
            "fromId": fromId,
            "toId": toId,
            "modifiedHour": modifiedHour,
            "content": content
        ]
    }
}
