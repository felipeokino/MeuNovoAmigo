//
//  Constants.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 02/09/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import Firebase

struct Constants {
    struct refs {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
