//
//  ChatTableViewCell.swift
//  MeuNovoAmigo
//
//  Created by Felipe Okino on 31/08/18.
//  Copyright © 2018 Felipe Okino. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var modifiedHour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
