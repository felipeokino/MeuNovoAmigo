//
//  MyPetTableViewCell.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 24/10/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit

class MyPetTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAdress: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
