//
//  MindfulnessViewerViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/18/21.
//

import UIKit
import PDFKit
class MindfulnessViewerViewController: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let pdfView = PDFView(frame: self.view.bounds)
        self.baseView.addSubview(pdfView)
        let fileURL = Bundle.main.url(forResource: KEY.PARAMETER.four_seven_eight_BreathingExercise, withExtension: KEY.EXTENSION.pdf)
        let pdfDocument = PDFDocument(url: fileURL!)
        pdfView.autoresizesSubviews = true
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        pdfView.displayDirection = .vertical
        
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
        pdfView.document = pdfDocument
        pdfView.maxScaleFactor = 4.0
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

