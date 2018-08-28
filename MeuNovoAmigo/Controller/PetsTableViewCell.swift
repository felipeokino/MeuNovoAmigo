//
//  PetsTableViewCell.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 14/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit

class PetsTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
