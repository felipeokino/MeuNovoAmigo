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
    
    private static var info: User?
    
    class func sharedUserInfo() -> User
    {
        if self.info == nil
        {
            self.info = User()
        }
        
        return self.info!
    }
    
    var name: String?
//    let birth: String
    var state: String?
    var city: String?
    var email: String?
    var image: String?
    
    init(){}
    
    init?(name: String, state: String, city: String, email: String){
        self.name = name
//        self.birth = birth
        self.state = state
        self.city = city
        self.email = email
    }
    init?(name: String, email: String, image: String){
        self.name = name
        self.image = image
        self.email = email
    }
    init?(dictionary: [String:Any]){
        self.name = dictionary["name"] as? String
//        self.birth = dictionary["birth"] as! String
        self.state = (dictionary["state"] as! String)
        self.email = dictionary["email"] as? String
        self.image = (dictionary["image"] as! String)
        self.city = dictionary["city"] as? String
    }
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
//            let birth = value["birth"] as? String,
            let state = value["state"] as? String,
            let email = value["email"] as? String,
            let image = value["image"] as? String,
            let city = value["city"] as? String else {
                return nil
        }
        self.name = name
//        self.birth = birth
        self.state = state
        self.city = city
        self.email = email
        self.image = image
    }
    func toAnyObject() -> Any {
        return [
            "name": name,
            "state": state,
            "email": email,
            "image": image,
            "city": city
        ]
    }
}
