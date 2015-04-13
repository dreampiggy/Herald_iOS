//
//  CommentTableViewCell.swift
//  Herald
//
//  Created by Wangshuo on 14-9-17.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    
    @IBOutlet var likeButton: MCFireworksButton!
    
    var commentsLabel:UILabel!
    
    @IBOutlet var commentsFloor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
