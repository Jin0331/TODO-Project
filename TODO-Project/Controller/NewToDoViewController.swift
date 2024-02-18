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
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.subItemView.forEach {
            return $0.rightButton.addTarget(self, action: #selector(itemRightButtonClicked), for: .touchUpInside)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면이 전환될때마다 save button에 대한 enable 판단 ---> 이 function으로 Realm에서 예외처리가 될 듯.  save button을 막아버림
        saveButtonEnable()
        
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
                             endDate: mainView.subItemView[NewToDoViewEnum.endTime.index].subLabel.text?.toDate(dateFormat: "yy.MM.dd"),
                             tag: mainView.subItemView[NewToDoViewEnum.tag.index].subLabel.text,
                             priority: mainView.subItemView[NewToDoViewEnum.priority.index].subLabel.text!,
                             flag : false,
                             completed: false
        )
        
        repository.createItem(item)
        repository.realmLocation()
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
                self.mainView.subItemView[eCase.index].subLabel.text = value.toString(dateFormat: "yy.M.d H시 m분")
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
    
    private func saveButtonEnable() {
        if let title = mainView.titleTextField.text,
           let _ = mainView.subItemView[NewToDoViewEnum.priority.index].subLabel.text {
            
            if title.count > 0 {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
}
