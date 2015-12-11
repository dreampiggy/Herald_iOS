//
//  ExamTableViewCell.swift
//  Herald
//
//  Created by lizhuoli on 15/12/11.
//  Copyright © 2015年 WangShuo. All rights reserved.
//

import UIKit

class ExamTableViewCell: UITableViewCell {

    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var teacher: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
