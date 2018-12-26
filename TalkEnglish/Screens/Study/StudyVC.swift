//
//  StudyVC.swift
//  TalkEnglish
//
//  Created by Thieu Mao on 12/13/17.
//  Copyright © 2017 thieumao. All rights reserved.
//

import UIKit
import PDFKit
import AVFoundation

class StudyVC: UIViewController {

    var index = 0
    var studyTitle = ""
    private var myPlayer: AVAudioPlayer?

    @IBOutlet weak var topPDFViewer: NSLayoutConstraint!
    @IBOutlet weak var pdfViewer: CustomPDFView!
    @IBOutlet weak var playerView: UIView!

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
    
    private let noAudioList = [1, 4, 6, 14]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = studyTitle
        openPDFViewer()
        checkVisible()
    }

    private func checkVisible() {
        let hasAudio = !noAudioList.contains(index)
        if !hasAudio {
            visibleForNoAudio()
        } else {
            visibleForHasAudio()
        }
    }

    private func visibleForHasAudio() {
        playerView.isHidden = false
        topPDFViewer.constant = playerView.bounds.height
    }

    private func visibleForNoAudio() {
        playerView.isHidden = true
        topPDFViewer.constant = 0
    }

    private func openPDFViewer() {
        guard let url = Bundle.main.url(forResource: "\(index)", withExtension: "pdf")
        else { return }
        let pdfdocument = PDFDocument(url: url)
        pdfViewer.document = pdfdocument
        pdfViewer.displayMode = PDFDisplayMode.singlePageContinuous
        pdfViewer.autoScales = true
    }
}

// IBAction - button click event
extension StudyVC {
    @IBAction func playButtonClicked(_ sender: Any) {
        playAudio("example.mp3")
    }
    
    @IBAction func pauseButtonClicked(_ sender: Any) {
        pauseAudio()
    }
    
    @IBAction func replayButtonClicked(_ sender: Any) {
        replayAudio()
    }
}

// Play MP3
extension StudyVC {
    func playAudio(_ fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            myPlayer = try AVAudioPlayer(contentsOf: url)
            myPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func pauseAudio() {
        myPlayer?.pause()
    }
    
    func replayAudio(){
        myPlayer?.play()
    }
}
