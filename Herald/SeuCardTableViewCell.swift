//
//  SeuCardTableViewCell.swift
//  Herald
//
//  Created by lizhuoli on 15/4/5.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class SeuCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardDateLabel: UILabel!
    @IBOutlet weak var cardPlaceLabel: UILabel!
    @IBOutlet weak var cardPriceLabel: UILabel!
    @IBOutlet weak var cardMoneyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
