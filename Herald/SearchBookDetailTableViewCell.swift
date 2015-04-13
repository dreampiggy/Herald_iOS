//
//  SearchBookDetailTableViewCell.swift
//  先声
//
//  Created by Wangshuo on 14-9-9.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class SearchBookDetailTableViewCell: UITableViewCell {

    
    @IBOutlet var bookName: UILabel!
    
    
    @IBOutlet var author: UILabel!
    
    
    
    @IBOutlet var publisher: UILabel!
    
    
    @IBOutlet var docType: UILabel!
    
    
    @IBOutlet var storeNum: UILabel!
    
    @IBOutlet var lendableNum: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
