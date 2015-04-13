//
//  EmptyRoomTableViewCell.swift
//  先声
//
//  Created by Wangshuo on 14-8-19.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class EmptyRoomTableViewCell: UITableViewCell {

    @IBOutlet var leftRoom: UILabel!
    
    
    @IBOutlet var rightRoom: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
