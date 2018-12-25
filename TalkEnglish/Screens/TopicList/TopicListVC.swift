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
    let topList = [
        "Đề nghị xin phép",
        "Giao tiếp công sở",
        "Giao tiếp đi mua sắm",
        "Giao tiếp đi tham quan",
        "Giao tiếp du lịch",
        "Giao tiếp hiệu chụp ảnh",
        "Giao tiếp phỏng vấn xin việc",
        "Giao tiếp tại bệnh viên",
        "Giao tiếp tại bưu điện",
        "Giao tiếp tại hiệu thuốc",
        "Giao tiếp tại ngân hàng",
        "Giao tiếp tại nhà ga",
        "Giao tiếp tại nhà hàng",
        "Giao tiếp tại rạp chiếu phim",
        "Giao tiếp văn phòng",
        "Hỏi thăm bạn bè",
        "Lần đầu gặp mặt",
        "Lo lắng buồn chán",
        "Nói về sở thích",
        "Tiếng Anh Giao Tiếp Thương Mại",
        "Vui Mừng Hạnh Phúc"
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
        return topList.count
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
        cell?.topicLabel.text = topList[indexPath.row]
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
        self.navigationController?.pushViewController(studyVC, animated: true)
    }
}
