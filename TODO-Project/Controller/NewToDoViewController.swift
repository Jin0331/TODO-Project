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
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "새로운 할 일"
        
        // left button
        let leftButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftButtonItemClicked)) // title 부분 수정
        navigationItem.leftBarButtonItem = leftButtonItem
        
        let rightButtonItem = UIBarButtonItem(title: "추가", style: .done, target: self, action: nil) // title 부분 수정
        navigationItem.rightBarButtonItem = rightButtonItem
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
    }
    
    @objc func leftButtonItemClicked(_ sender : UIButton) {
        dismiss(animated: true)
    }

}
