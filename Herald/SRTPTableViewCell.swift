//
//  SRTPTableViewCell.swift
//  先声
//
//  Created by Wangshuo on 14-9-4.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class SRTPTableViewCell: UITableViewCell {

    
    @IBOutlet var creditLabel: UILabel!
    
    @IBOutlet var projectLabel: UILabel!
    
    @IBOutlet var propertyLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
