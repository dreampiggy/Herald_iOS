//
//  GradeTableViewCell.swift
//  先声
//
//  Created by Wangshuo on 14-9-3.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class GradeTableViewCell: UITableViewCell {

    
    
    @IBOutlet var nameLabel: UILabel!
    
    
    @IBOutlet var gradeLabel: UILabel!
    
    
    @IBOutlet var creditLabel: UILabel!
    
    @IBOutlet var propertyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
