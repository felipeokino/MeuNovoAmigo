//
//  User.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 10/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import Foundation
import Firebase

class User {
    let name: String
    let cpf: String
    let state: String
    let city: String
    let email: String
    var image: String?
    
    init(name: String, cpf: String, state: String, city: String, email: String){
        self.name = name
        self.cpf = cpf
        self.state = state
        self.city = city
        self.email = email
    }
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let cpf = value["cpf"] as? String,
            let state = value["state"] as? String,
            let email = value["email"] as? String,
            let image = value["image"] as? String,
            let city = value["city"] as? String else {
                return nil
        }
        self.name = name
        self.cpf = cpf
        self.state = state
        self.city = city
        self.email = email
        self.image = image
    }
}
