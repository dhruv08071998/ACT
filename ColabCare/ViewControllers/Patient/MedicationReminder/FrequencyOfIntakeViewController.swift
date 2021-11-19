//
//  FrequencyOfIntakeViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/5/21.
//

import UIKit

class FrequencyOfIntakeViewController: UIViewController {

    @IBOutlet weak var lblEvery: UILabel!
    @IBOutlet weak var lblEveryHeading: UILabel!
    @IBOutlet weak var lblSeperation: UILabel!
    @IBOutlet weak var btnCheckEveryX: UIButton!
    @IBOutlet weak var btnCheckDailyXTime: UIButton!
    var isDaily = false
    var isXdays = false
    var toolBar = UIToolbar()
    @IBOutlet weak var viewEveryDays: UIView!
    var picker  = UIPickerView()
    var arrDays: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        for i in 1...101{
            arrDays.append(String(i))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewEveryDays.isHidden = true
        lblEvery.text = "2 days"
        if frequencyGlobal == "Daily" {
            btnDailyTapped(self)
        } else {
            btnEveryXdaysTapped(self)
            lblEvery.text = frequencyGlobal
        }
        changeBackground(view: view)
    }
    
    @IBAction func btnDailyTapped(_ sender: Any) {
        if isDaily {
            btnCheckDailyXTime.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isDaily = !isDaily
        } else {
            btnCheckDailyXTime.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioCheck), for: .normal)
            isDaily = !isDaily
            btnCheckEveryX.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isXdays = false
            viewEveryDays.isHidden = true

        }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        if isXdays{
            frequencyGlobal = lblEvery.text!
        }
        if isDaily{
            frequencyGlobal = "Daily"
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnEveryXdaysTapped(_ sender: Any) {
        if isXdays {
            btnCheckEveryX.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isXdays = !isXdays
        } else {
            btnCheckEveryX.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioCheck), for: .normal)
            isXdays = !isXdays
            btnCheckDailyXTime.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isDaily = false
            viewEveryDays.isHidden = false
        }
    }

    @IBAction func btnViewEveryTapped(_ sender: Any) {
        openPickerView()
    }
    
    func openPickerView() {
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
}

extension FrequencyOfIntakeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrDays.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrDays[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblEvery.text =  arrDays[row] + " days"
    }
}
