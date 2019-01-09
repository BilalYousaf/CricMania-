//
//  CalenderCell.swift
//  CMJSON
//
//  Created by Bilal Yousaf on 02/01/2018.
//  Copyright © 2018 Bilal Yousaf. All rights reserved.
//

import UIKit

class CalenderCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
