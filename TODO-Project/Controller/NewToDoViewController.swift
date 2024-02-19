//
//  NewTodoViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import RealmSwift

class NewToDoViewController: BaseViewController {
    
    let mainView = NewToDoView()
    let repository = ToDoTableRepository()
    var countUpdate : (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.subItemView.forEach {
            return $0.rightButton.addTarget(self, action: #selector(itemRightButtonClicked), for: .touchUpInside)
        }
        
        //MARK: - 저장 버튼 활성화, textfield에 data(>2)가 입력되었을 때 반영되도록.
        mainView.titleTextField.becomeFirstResponder()
        mainView.titleTextField.addTarget(self, action: #selector(saveButtonEnable), for: .editingDidBegin)
        
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "새로운 할 일"
        
        // left button
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleButtonItemClicked)) // title 부분 수정
        let saveButton = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(saveButton)) // title 부분 수정
        
        saveButton.isEnabled = false
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    @objc func cancleButtonItemClicked(_ sender : UIButton) {
        dismiss(animated: true)
    }
    
    @objc func saveButton(_ sender : UIButton) {
        
        let item = ToDoTable(title: mainView.titleTextField.text!,
                             memo: mainView.memoTextView.text,
                             endDate: mainView.subItemView[NewToDoViewEnum.endTime.index].subLabel.text?.toDate(dateFormat: "yy.MM.dd") ?? nil,
                             tag: mainView.subItemView[NewToDoViewEnum.tag.index].subLabel.text,
                             priority: mainView.subItemView[NewToDoViewEnum.priority.index].subLabel.text,
                             flag : false,
                             completed: false
        )
        
        repository.createItem(item)
        repository.realmLocation()
        
        countUpdate?() // 이전 화면 함수 호출
        
        dismiss(animated: true)
        
    }
    
    // subView objc func
    @objc func itemRightButtonClicked(_ sender : UIButton) {
        
        print(#function)
        let eCase = NewToDoViewEnum(rawValue: sender.tag) // tag의 값이 불명확하므로, eCase는 option value가 됨
        guard let eCase = eCase else { return }
        
        switch eCase {
        case .endTime :
            let vc = DateViewController()
            vc.datePickerSpace = { value in
                self.mainView.subItemView[eCase.index].subLabel.text = value.toString(dateFormat: "yy.MM.dd")
            }
            navigationController?.pushViewController(vc, animated: true)
        case .tag :
            let vc = TagViewController()
            vc.tagTextFieldSpace = { value in
                self.mainView.subItemView[eCase.index].subLabel.text = value
            }
            navigationController?.pushViewController(vc, animated: true)
        case .priority :
            let vc = PriorityViewController()
            vc.prioritySegmentSpace = { value in
                self.mainView.subItemView[eCase.index].subLabel.text = "\(value)"
            }
            navigationController?.pushViewController(vc, animated: true)
        default :
            print("아직 구현 안 됨")
        }
    }
    
    @objc func saveButtonEnable(_ sender : UITextField) {
        
        print(#function)
        var title = sender.text!
        
        if let title = mainView.titleTextField.text, title.count > 1 {
            
            navigationItem.rightBarButtonItem?.isEnabled = true
            
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
}
