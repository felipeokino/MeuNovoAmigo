//
//  Pet.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 12/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class Pet {
    let species: String
    let description: String
    var image: String?
    let owner: String
    
    init(species: String, description: String, owner: String) {
        self.species = species
        self.description = description
        self.owner = owner
    }
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let species = value["specie"] as? String,
            let image = value["image"] as? String,
            let description = value["description"] as? String,
            let owner = value["owner"] as? String else {
                return nil
        }
        self.species = species
        self.description = description
        self.image = image
        self.owner = owner
    }
    
    func toAnyObject() -> Any {
        return [
            "species": species,
            "description": description,
            "image": image!,
            "owner": owner,
            "flag": "new"
        ]
    }
}
