//
//  User.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 10/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import Foundation

class User {
    let name: String
    let cpf: String
    let postalCode: String
    let street: String
    let state: String
    let number: String
    let phoneNumber: String
    let city: String
    let email: String
    
    init(name: String, cpf: String, postalCode: String, street: String, number: String,state: String, phoneNumber: String, city: String, email: String){
        self.name = name
        self.cpf = cpf
        self.postalCode = postalCode
        self.street = street
        self.state = state
        self.number = number
        self.phoneNumber = phoneNumber
        self.city = city
        self.email = email
    }
}
