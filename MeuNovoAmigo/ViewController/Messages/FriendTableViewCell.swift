//
//  FriendTableViewCell.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 27/09/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
