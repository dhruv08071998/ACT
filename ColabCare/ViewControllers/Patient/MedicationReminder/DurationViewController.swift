//
//  DurationViewController.swift
//  ColabCare
//
//  Created by dhruv upadhyay on 6/5/21.
//

import UIKit

class DurationViewController: UIViewController {
    
    @IBOutlet weak var lblFreqHeading: UILabel!
    @IBOutlet weak var lblDurationHeading: UILabel!
    @IBOutlet weak var btnCheckForXDays: UIButton!
    @IBOutlet weak var btnCheckUntillDate: UIButton!
    @IBOutlet weak var btnCheckNoEndDate: UIButton!
    @IBOutlet weak var lblSecondLine: UILabel!
    @IBOutlet weak var lblFreqIntake: UILabel!
    @IBOutlet weak var viewFreqIntake: UIView!
    @IBOutlet weak var lblDuration: UILabel!
    var txtStartDate = UITextField()
    let datePicker = UIDatePicker()
    var isEndDate = false
    var isXdays = false
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var isUntillDate = false
    var arrDays: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        btnCheckForXDays.addTarget(self, action: #selector(btnCheckForXDaysTapped(_:)), for: .touchUpInside)
        btnCheckUntillDate.addTarget(self, action: #selector(btnCheckUntillDateTapped(_:)), for: .touchUpInside)
        btnCheckNoEndDate.addTarget(self, action: #selector(btnCheckNoEndDateTapped(_:)), for: .touchUpInside)
        for i in 1...101{
            arrDays.append(String(i))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Duration")!)
        viewFreqIntake.isHidden = true
        lblDuration.text = startDate
        if durationGlobal == "No End Date"{
            btnCheckNoEndDateTapped(btnCheckNoEndDate)
        } else if durationGlobal!.contains("days") {
            btnCheckForXDaysTapped(btnCheckForXDays)
            lblFreqIntake.text = durationGlobal
        } else {
            btnCheckUntillDateTapped(btnCheckUntillDate)
            lblFreqIntake.text = durationGlobal
        }
        changeBackground(view: view)
    }
    @IBAction func btnNoEndDateTapped(_ sender: Any) {
        btnCheckNoEndDateTapped(btnCheckNoEndDate)
    }
    @IBAction func btnUnitillDateTapped(_ sender: Any) {
        btnCheckUntillDateTapped(btnCheckUntillDate)
    }
    
    @IBAction func btnForXDaysTapped(_ sender: Any) {
        btnCheckForXDaysTapped(btnCheckForXDays)
    }
    @objc func btnCheckNoEndDateTapped(_ sender: UIButton) {
        if isEndDate {
            btnCheckNoEndDate.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isEndDate = !isEndDate
        } else {
            btnCheckNoEndDate.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioCheck), for: .normal)
            isEndDate = !isEndDate
            btnCheckForXDays.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isXdays = false
            btnCheckUntillDate.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isUntillDate = false
            viewFreqIntake.isHidden = true
        }
        
    }
    @objc func btnCheckForXDaysTapped(_ sender: UIButton) {
        if isXdays {
            btnCheckForXDays.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isXdays = !isXdays
        } else {
            btnCheckForXDays.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioCheck), for: .normal)
            isXdays = !isXdays
            btnCheckNoEndDate.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isEndDate = false
            btnCheckUntillDate.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isUntillDate = false
            viewFreqIntake.isHidden = false
            lblFreqIntake.text = "10"
            lblFreqHeading.text = "Duration"
        }
        
    }
    @objc func btnCheckUntillDateTapped(_ sender: UIButton) {
        if isUntillDate {
            btnCheckUntillDate.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isUntillDate = !isUntillDate
        } else {
            btnCheckUntillDate.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioCheck), for: .normal)
            isUntillDate = !isUntillDate
            btnCheckNoEndDate.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isEndDate = false
            btnCheckForXDays.setImage(UIImage(named: KEY.BUTTONTITLE.BtnRadioUncheck), for: .normal)
            isXdays = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let time = dateFormatter.string(from: Date().stripTime())
            lblFreqIntake.text = time
            lblFreqHeading.text = "Untill"
            viewFreqIntake.isHidden = false
        }
        
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
    
    @IBAction func btnDurationTapped(_ sender: Any) {
        openDatePicker()
    }
    
    func openDatePicker() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } 
        datePicker.backgroundColor = UIColor.white
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        if let date = sender?.date {
            let currDate = dateFormatter.string(from: date)
            if isUntillDate{
                lblFreqIntake.text = currDate
            } else {
                if Date().stripTime().dateFormat()  == date.dateFormat() {
                    lblDuration.text = "Today"
                } else {
                    lblDuration.text = currDate
                }
            }
        }
    }
    
    @objc func onDoneButtonClick() {
        isUntillDate = false
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    @IBAction func btnFreqIntakeTapped(_ sender: Any) {
        if lblFreqHeading.text == "Untill"{
            isUntillDate = true
            openDatePicker()
        } else {
            openPickerView()
        }
    }
    @IBAction func btnCloseTapped(_ sender: Any) {
        startDate = lblDuration.text
        if lblFreqHeading.text == "Untill"{
            durationGlobal = lblFreqIntake.text!
        }
        if isXdays{
            durationGlobal = lblFreqIntake.text! + " days"
        }
        if isEndDate{
            durationGlobal = "No End Date"
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }

    
}

extension Date{
    func dateFormat() -> String {
        let datePicker = UIDatePicker()
        let formatter = DateFormatter()
        formatter.dateFormat = KEY.DateTime.DateFormat
        formatter.calendar = datePicker.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
}


extension DurationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        lblFreqIntake.text =  arrDays[row]
    }
}

