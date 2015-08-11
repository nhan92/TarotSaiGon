//
//  RunesTableViewCell.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 8/11/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class RunesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myRunesImages: UIImageView!

    @IBOutlet weak var myRunesText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
