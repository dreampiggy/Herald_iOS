//
//  CurriculumTableViewCell.swift
//  先声
//
//  Created by Wangshuo on 14-8-21.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class CurriculumTableViewCell: UITableViewCell {

    
    @IBOutlet var timeofLesson: UILabel!
    
    @IBOutlet var nameofLesson: UILabel!
    
    @IBOutlet var placeofLesson: UILabel!
    
    @IBOutlet var weekofLesson: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
