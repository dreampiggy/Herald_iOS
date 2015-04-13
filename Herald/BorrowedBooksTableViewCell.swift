//
//  BorrowedBooksTableViewCell.swift
//  先声
//
//  Created by Wangshuo on 14-9-8.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class BorrowedBooksTableViewCell: UITableViewCell {

    
    @IBOutlet var bookName: UILabel!
    
    
    @IBOutlet var barCode: UILabel!
    
    @IBOutlet var author: UILabel!
    
    
    @IBOutlet var borrowDate: UILabel!
    
    
    @IBOutlet var dueDate: UILabel!
    
    
    @IBOutlet var renewTime: UILabel!
    
    
    @IBOutlet var collectionSite: UILabel!
    
    @IBOutlet var renewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
