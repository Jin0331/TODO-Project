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
    let repository = RealmRepository()
    var countUpdate : (() -> Void)? // main으로 보내는 closure
    var taskGroupList : TaskGroup!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.subItemView.forEach {
            
            return $0.labelButton.addTarget(self, action: #selector(cellClicked), for: .touchUpInside)
        }
        
        //MARK: - 저장 버튼 활성화, textfield에 data(>2)가 입력되었을 때 반영되도록.
        mainView.titleTextField.becomeFirstResponder()
        mainView.titleTextField.addTarget(self, action: #selector(saveButtonEnable), for: .editingDidEnd)
        
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
                             endDate: mainView.subItemView[NewToDoViewEnum.endTime.index].subLabel.text?.toDate(dateFormat: "yy.MM.dd H:m") ?? nil,
                             tag: mainView.subItemView[NewToDoViewEnum.tag.index].subLabel.text,
                             priority: mainView.subItemView[NewToDoViewEnum.priority.index].subLabel.text,
                             flag : false,
                             completed: false
        )
        
        repository.createRelation(destination: taskGroupList, from: item)
        
//        taskGroupList.todo.append(item)
        
        // PK별 이미지 추가
        if let image = mainView.subItemView[NewToDoViewEnum.addImage.index].rightImageView.image {
            saveImageToDocument(image: image, pk: "\(item._id)")
        }
        
        repository.realmLocation()
        
        countUpdate?() // 이전 화면 함수 호출
        
        dismiss(animated: true)
        
    }
    
    // subView objc func -- 같은 VC 사용
    @objc func cellClicked(_ sender : UIButton) {
        
        print(#function)
        let eCase = NewToDoViewEnum(rawValue: sender.tag) // tag의 값이 불명확하므로, eCase는 option value가 됨
        guard let eCase = eCase else { return }
        
        switch eCase {
        case .endTime :
            let vc = DateViewController()
            vc.navTitle = eCase.title
            vc.datePickerSpace = { value in
                self.mainView.subItemView[eCase.index].subLabel.text = value.toString(dateFormat: "yy.MM.dd H:m")
            }
            navigationController?.pushViewController(vc, animated: true)
        case .tag :
            let vc = TagViewController()
            vc.navTitle = eCase.title
            vc.tagTextFieldSpace = { value in
                self.mainView.subItemView[eCase.index].subLabel.text = value
            }
            navigationController?.pushViewController(vc, animated: true)
        case .priority :
            let vc = PriorityViewController()
            vc.navTitle = eCase.title
            vc.prioritySegmentSpace = { value in
                self.mainView.subItemView[eCase.index].subLabel.text = "\(value)"
            }
            navigationController?.pushViewController(vc, animated: true)
        case .addImage :
            let vc = UIImagePickerController()
            vc.allowsEditing = true
            vc.delegate = self

            present(vc, animated: true)
        case .group :
            let vc = GroupViewController()
            vc.navTitle = eCase.title
            vc.taskGroupListSender = { value in
                self.taskGroupList = value
                self.mainView.subItemView[eCase.index].subLabel.text = "\(self.taskGroupList.groupName)"
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func saveButtonEnable(_ sender : UITextField) {
        
        print(#function)
        if let title = sender.text, title.count > 1, 
            let taskGroup = mainView.subItemView[NewToDoViewEnum.group.index].subLabel.text {
            navigationItem.rightBarButtonItem?.isEnabled = true
            
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
}

//MARK: - Image picker
extension NewToDoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(#function)
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        mainView.subItemView[NewToDoViewEnum.addImage.index].rightImageView.image = pickedImage
        
        dismiss(animated: true)
    }
}
