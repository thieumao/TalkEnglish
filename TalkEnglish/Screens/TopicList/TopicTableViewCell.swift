//
//  TopicTableViewCell.swift
//  TalkEnglish
//
//  Created by Nguyen Van Thieu on 12/25/18.
//  Copyright © 2018 thieumao. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    var index = 0
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var topicButton: UIButton!
    
    @IBAction func topicClicked(_ sender: Any) {
        print("Thieu Mao \(index)")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
