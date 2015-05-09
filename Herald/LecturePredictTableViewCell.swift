//
//  LectureTableViewCell.swift
//  Herald
//
//  Created by lizhuoli on 15/4/5.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class LecturePredictTableViewCell: UITableViewCell {

    @IBOutlet weak var lectureNoticeDateLabel: UILabel!
    
    @IBOutlet weak var lectureNoticeTopicLabel: UILabel!
    @IBOutlet weak var lectureNoticeSpeakerLabel: UILabel!
    
    @IBOutlet weak var lectureNoticeLocationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
