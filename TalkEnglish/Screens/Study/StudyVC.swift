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
    // public
    var index = 0
    var studyTitle = ""

    // player
    private var myPlayer: AVAudioPlayer?

    // check visible views
    private let HEIGHT_PLAYER: CGFloat = 64.0
    private var hasAudio: Bool = true

    // gesture
    private var panRecognizer: UIPanGestureRecognizer?
    private var panStartPoint: CGPoint?

    // outlet
    @IBOutlet weak var heightPlayer: NSLayoutConstraint!
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
//        "Tiếng Anh Giao Tiếp Thương Mại" // 20
    ]
    
    private let noAudioList = [1, 4, 6, 14, 20]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = studyTitle
        openPDFViewer()
        checkVisible()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Gesture for PDF Viewer
extension StudyVC: UIGestureRecognizerDelegate {
    // enable gesture
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }

    private func addPanGesture() {
        panRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panThisPDF(recognizer:)))
        panRecognizer?.delegate = self
        if let pan = panRecognizer {
            pdfViewer.addGestureRecognizer(pan)
        }
    }

    @objc func panThisPDF(recognizer: UIPanGestureRecognizer) {
        switch (recognizer.state) {
        case .began:
            panStartPoint = recognizer.translation(in: self.pdfViewer)
            break;
        case .changed:
            let currentPoint = recognizer.translation(in: self.pdfViewer)
            guard let panStartPoint = panStartPoint else { return }
            let distance = currentPoint.y - panStartPoint.y
            print("distance = \(distance)")
            if distance < -100 {
                // show
                showFull()
            } else if distance > 100 {
                // hide
                showNormal()
            } else {
                // nothing
            }
            break;
        case .ended:
            break;
        case .cancelled:
            break;
        default:
            break;
        }
    }
}

// MARK: View & Check Visible
extension StudyVC {
    private func checkVisible() {
        hasAudio = !noAudioList.contains(index)
        if !hasAudio {
            visibleForNoAudio()
        } else {
            visibleForHasAudio()
        }
    }

    private func visibleForNoAudio() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.heightPlayer.constant = 0
            self.topPDFViewer.constant = 0
            self.playerView.isHidden = true
            self.navigationController?.navigationBar.isHidden = false
        }, completion: nil)
    }

    private func visibleForHasAudio() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.playerView.isHidden = false
            self.topPDFViewer.constant = self.HEIGHT_PLAYER
            self.navigationController?.navigationBar.isHidden = false
        }, completion: nil)
    }

    private func showFull() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.playerView.isHidden = true
            self.topPDFViewer.constant = 1
            self.navigationController?.navigationBar.isHidden = true
        }, completion: nil)
    }

    private func showNormal() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.playerView.isHidden = self.hasAudio ? false : true
            self.topPDFViewer.constant = self.hasAudio ? self.HEIGHT_PLAYER : 1
            self.navigationController?.navigationBar.isHidden = false
        }, completion: nil)
    }

    private func openPDFViewer() {
        guard let url = Bundle.main.url(forResource: "\(index)", withExtension: "pdf")
            else { return }
        let pdfdocument = PDFDocument(url: url)
        pdfViewer.document = pdfdocument
        pdfViewer.displayMode = PDFDisplayMode.singlePageContinuous
        pdfViewer.autoScales = true

        addPanGesture()
    }
}

// MARK: IBAction - button click event
extension StudyVC {
    @IBAction func playButtonClicked(_ sender: Any) {
        playAudio("\(index).mp3")
    }
    
    @IBAction func pauseButtonClicked(_ sender: Any) {
        pauseAudio()
    }
    
    @IBAction func replayButtonClicked(_ sender: Any) {
        replayAudio()
    }
}

// MARK: Play MP3
extension StudyVC {
    private func playAudio(_ fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType:nil) else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            myPlayer = try AVAudioPlayer(contentsOf: url)
            myPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    private func pauseAudio() {
        myPlayer?.pause()
    }
    
    private func replayAudio(){
        myPlayer?.play()
    }
}
