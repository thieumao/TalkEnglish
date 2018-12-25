//
//  TopicListVC.swift
//  TalkEnglish
//
//  Created by Nguyen Van Thieu on 12/25/18.
//  Copyright © 2018 thieumao. All rights reserved.
//

import UIKit

class TopicListVC: UIViewController {

    //  21 tình huống giao tiếp thường gặp
    private let topics = [
        "Đề nghị xin phép", // 0
        "Giao tiếp công sở", // 1
        "Giao tiếp đi mua sắm", // 2
        "Giao tiếp đi tham quan", // 3
        "Giao tiếp du lịch", // 4
        "Giao tiếp hiệu chụp ảnh", // 5
        "Giao tiếp phỏng vấn xin việc", // 6
        "Giao tiếp tại bệnh viên", // 7
        "Giao tiếp tại bưu điện", // 8
        "Giao tiếp tại hiệu thuốc", // 9
        "Giao tiếp tại ngân hàng", // 10
        "Giao tiếp tại nhà ga", // 11
        "Giao tiếp tại nhà hàng", // 12
        "Giao tiếp tại rạp chiếu phim", // 13
        "Giao tiếp văn phòng", // 14
        "Hỏi thăm bạn bè", // 15
        "Lần đầu gặp mặt", // 16
        "Lo lắng buồn chán", // 17
        "Nói về sở thích", // 18
        "Vui Mừng Hạnh Phúc", // 19
        "Tiếng Anh Giao Tiếp Thương Mại" // 20
    ]

    @IBOutlet weak var myTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
    }
}

extension TopicListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: TopicTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell") as? TopicTableViewCell
        if cell == nil {
            tableView.register(
                UINib(nibName: "TopicTableViewCell", bundle: nil),
                forCellReuseIdentifier: "TopicTableViewCell"
            )
            cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell") as? TopicTableViewCell
        }
        cell?.topicLabel.text = topics[indexPath.row]
        cell?.index = indexPath.row
        cell?.clickedTopicClosure = { [weak self] index in
            self?.pushStudyVC(index)
        }
        return cell ?? UITableViewCell()
    }

    private func pushStudyVC(_ index: Int) {
        print("Click Study VC \(index)")
        guard let studyVC = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "StudyVC") as? StudyVC
        else { return }
        studyVC.index = index
        studyVC.studyTitle = topics[index]
        self.navigationController?.pushViewController(studyVC, animated: true)
    }
}
