//
//  NewGroupViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/20/24.
//

import UIKit

class NewGroupViewController: BaseViewController {
    
    let mainView = NewGroup()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = "새로운 목록"
        // left button
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleButtonItemClicked)) // title 부분 수정
        let saveButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(saveButton)) // title 부분 수정
        
        saveButton.isEnabled = false
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func cancleButtonItemClicked(_ sender : UIButton) {
        dismiss(animated: true)
    }
    
    @objc func saveButton(_ sender : UIButton) {
        
        //        let item = ToDoTable(title: mainView.titleTextField.text!,
        //                             memo: mainView.memoTextView.text,
        //                             endDate: mainView.subItemView[NewToDoViewEnum.endTime.index].subLabel.text?.toDate(dateFormat: "yy.MM.dd H:m") ?? nil,
        //                             tag: mainView.subItemView[NewToDoViewEnum.tag.index].subLabel.text,
        //                             priority: mainView.subItemView[NewToDoViewEnum.priority.index].subLabel.text,
        //                             flag : false,
        //                             completed: false
        //        )
        //
        //        repository.createItem(item)
        //
        //        // PK별 이미지 추가
        //        if let image = mainView.subItemView[NewToDoViewEnum.addImage.index].rightImageView.image {
        //            saveImageToDocument(image: image, pk: "\(item._id)")
        //        }
        //
        //        repository.realmLocation()
        //
        //        countUpdate?() // 이전 화면 함수 호출
        
        dismiss(animated: true)
    }
}
