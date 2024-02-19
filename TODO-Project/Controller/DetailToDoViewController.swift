//
//  DetailToDoViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/18/24.
//

import UIKit
import RealmSwift

class DetailToDoViewController: NewToDoViewController {
    
    var dataList : ToDoTable?
    var tableViewReload : (() -> Void)?
    
    override func configureView() {

        guard let dataList = dataList else { return }
        
        mainView.titleTextField.text = dataList.title
        mainView.memoTextView.text = dataList.memo
        mainView.subItemView[0].subLabel.text = dataList.endDate?.toString(dateFormat: "yy.MM.dd")
        mainView.subItemView[1].subLabel.text = dataList.tag
        mainView.subItemView[2].subLabel.text = dataList.priority
        
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "상세 화면"
        
        // left button
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleButtonItemClicked)) // title 부분 수정
        let saveButton = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(saveButton)) // title 부분 수정
        
        saveButton.isEnabled = false
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc override func saveButton(_ sender : UIButton) {
        
        guard let dataList = dataList else { return }
        
        repository.updateItem(id: dataList._id,
                              title: mainView.titleTextField.text!,
                              memo: mainView.memoTextView.text,
                              endDate: mainView.subItemView[0].subLabel.text?.toDate(dateFormat: "yy.MM.dd") ?? nil,
                              tag: mainView.subItemView[1].subLabel.text,
                              priority: mainView.subItemView[2].subLabel.text)
        
        dismiss(animated: true)
        tableViewReload?()
        
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
