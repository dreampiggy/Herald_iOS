//
//  SchoolBusTableViewCell.swift
//  Herald
//
//  Created by lizhuoli on 15/4/7.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class SchoolBusTableViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var busLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
