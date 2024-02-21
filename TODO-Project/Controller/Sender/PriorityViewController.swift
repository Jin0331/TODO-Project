//
//  PriorityViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import SnapKit
import Then

class PriorityViewController: BaseViewController {
    
    var prioritySegmentSpace : ((Int) -> Void)?
    var navTitle : String?
    
    let prioritySegment = UISegmentedControl(items: ["Low","Medium","High"]).then {
        $0.selectedSegmentIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prioritySegment.addTarget(self, action: #selector(prioritySegmentValueChanged), for: .valueChanged)

    }
    
    override func configureHierarchy() {
        view.addSubview(prioritySegment)
    }

    override func configureLayout() {
        prioritySegment.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        if let navTitle {
            navigationItem.title = navTitle
        }
    }
    
    @objc func prioritySegmentValueChanged(_ sender : UISegmentedControl) {
        prioritySegmentSpace?(sender.selectedSegmentIndex)
    }
}
