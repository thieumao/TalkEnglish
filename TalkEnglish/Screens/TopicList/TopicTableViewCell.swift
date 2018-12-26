//
//  TopicTableViewCell.swift
//  TalkEnglish
//
//  Created by Nguyen Van Thieu on 12/25/18.
//  Copyright © 2018 thieumao. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var topicButton: UIButton!
    var index = 0
    var clickedTopicClosure: ((_ index: Int) -> Void)?
    
    @IBAction func topicClicked(_ sender: Any) {
        print("Thieu Mao \(index)")
        clickedTopicClosure?(index)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
