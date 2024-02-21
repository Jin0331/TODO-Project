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
    var realm = try! Realm()
    
    override func configureView() {

        guard let dataList = dataList else { return }
        
        mainView.titleTextField.text = dataList.title
        mainView.memoTextView.text = dataList.memo
        mainView.subItemView[NewToDoViewEnum.endTime.index].subLabel.text = dataList.endDate?.toString(dateFormat: "yy.MM.dd H:m")
        mainView.subItemView[NewToDoViewEnum.tag.index].subLabel.text = dataList.tag
        mainView.subItemView[NewToDoViewEnum.priority.index].subLabel.text = dataList.priority
        mainView.subItemView[NewToDoViewEnum.addImage.index].rightImageView.image = loadImageToDocument(pk: dataList._id.stringValue)
        mainView.subItemView[NewToDoViewEnum.group.index].subLabel.text = dataList.taskGroup.first?.groupName
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
                              endDate: mainView.subItemView[0].subLabel.text?.toDate(dateFormat: "yy.MM.dd H:m") ?? nil,
                              tag: mainView.subItemView[1].subLabel.text,
                              priority: mainView.subItemView[2].subLabel.text
        )
        // 기존 ID가 삭제가 안 됨.
        
        // 새로운 연결
        repository.createRelation(destination: taskGroupList, from: dataList)
        
        
        // PK별 이미지 추가
        if let image = mainView.subItemView[NewToDoViewEnum.addImage.index].rightImageView.image {
            saveImageToDocument(image: image, pk: "\(dataList._id)")
        }
        
        dismiss(animated: true)
        tableViewReload?()
        
    }
    
//    @objc override func cellClicked(_ sender : UIButton) {
//        
//        print(#function)
//        let eCase = NewToDoViewEnum(rawValue: sender.tag) // tag의 값이 불명확하므로, eCase는 option value가 됨
//        guard let eCase = eCase else { return }
//        
//        switch eCase {
//        case .endTime :
//            let vc = DateViewController()
//            vc.navTitle = eCase.title
//            vc.datePickerSpace = { value in
//                self.mainView.subItemView[eCase.index].subLabel.text = value.toString(dateFormat: "yy.MM.dd H:m")
//            }
//            navigationController?.pushViewController(vc, animated: true)
//        case .tag :
//            let vc = TagViewController()
//            vc.navTitle = eCase.title
//            vc.tagTextFieldSpace = { value in
//                self.mainView.subItemView[eCase.index].subLabel.text = value
//            }
//            navigationController?.pushViewController(vc, animated: true)
//        case .priority :
//            let vc = PriorityViewController()
//            vc.navTitle = eCase.title
//            vc.prioritySegmentSpace = { value in
//                self.mainView.subItemView[eCase.index].subLabel.text = "\(value)"
//            }
//            navigationController?.pushViewController(vc, animated: true)
//        case .addImage :
//            let vc = UIImagePickerController()
//            vc.allowsEditing = true
//            vc.delegate = self
//
//            present(vc, animated: true)
//        case .group :
//            let vc = GroupViewController()
//            vc.navTitle = eCase.title
//            vc.taskGroupListSender = { value in
//                self.taskGroupList = value
//                self.mainView.subItemView[eCase.index].subLabel.text = "\(self.taskGroupList.groupName)"
//            }
//            
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    
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
