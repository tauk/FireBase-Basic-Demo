//
//  AllUsersTableViewCell.swift
//  FireBaseDBAndStorage
//
//  Created by Tauseef Kamal on 12/3/16.
//  Copyright © 2016 Tauseef Kamal. All rights reserved.
//

import UIKit

class AllUsersTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userNameEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
