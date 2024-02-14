//
//  NewTodoViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit

class NewToDoViewController: BaseViewController {

    let mainView = NewToDoView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.subItemView.forEach {
            return $0.rightButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        }

    }
    
    @objc func rightButtonClicked(_ sender : UIButton) {
        
        print(#function)
        print(sender.tag)
        
        switch sender.tag {
        case 0 :
            let vc = DateViewController()
            vc.datePickerSpace = { value in
                self.mainView.subItemView[sender.tag].subLabel.text = value
            }
            navigationController?.pushViewController(vc, animated: true)
        case 1 :
            let vc = TagViewController()
            vc.tagTextFieldSpace = { value in
                self.mainView.subItemView[sender.tag].subLabel.text = value
                print(value)
            }
            navigationController?.pushViewController(vc, animated: true)
        case 2 :
            let vc = PriorityViewController()
            vc.prioritySegmentSpace = { value in
                self.mainView.subItemView[sender.tag].subLabel.text = "\(value)"
                print(value)
            }
            navigationController?.pushViewController(vc, animated: true)
        default :
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
            

        }
        
//
    }

}
