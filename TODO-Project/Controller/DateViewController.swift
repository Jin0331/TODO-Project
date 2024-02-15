//
//  DateViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import SnapKit
import Then

class DateViewController: BaseViewController {
    
    var datePickerSpace : ((String) -> Void)?

    let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)

    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
        
    }
  
    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
    }
    
    //TODO: - DatePicker 글씨색 변경 필요
    override func configureView() {
        super.configureView()
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        datePickerSpace?(dateFormat(date: sender.date))
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return formatter.string(from: date)
    }


}
