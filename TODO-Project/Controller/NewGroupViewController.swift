//
//  NewGroupViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/20/24.
//

import UIKit
import RealmSwift

class NewGroupViewController: BaseViewController {
    
    let repository = RealmRepository()
    let mainView = NewGroup()
    
    var tintColor : String?
    var systemIcon : String?
    var uiUpdate : (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.groupNameTextfield.becomeFirstResponder()
        mainView.groupNameTextfield.addTarget(self, action: #selector(saveButtonEnable), for: .editingDidEnd)
        
    }
    
    override func configureView() {
        mainView.colorCollectionView.delegate = self
        mainView.colorCollectionView.dataSource = self
        mainView.iconCollectionView.delegate = self
        mainView.iconCollectionView.dataSource = self
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        let selectedIndexPath = IndexPath(item: 0, section: 0)
//        mainView.colorCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
//    }
    
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
        
        // Icon property 저장 (embedded
        let icon = Icon()
        icon.colorHex = tintColor!
        icon.systemIcon = systemIcon!
        
        let item = TaskGroup(groupName: mainView.groupNameTextfield.text!, icon: icon)
        
        repository.createItem(item)
        repository.realmLocation()
        
        uiUpdate?()
        
        dismiss(animated: true)
    }
    
    @objc func saveButtonEnable(_ sender : UITextField) {
        
        print(#function)
        if let title = sender.text, title.count > 1 {
            navigationItem.rightBarButtonItem?.isEnabled = true
            
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
}


extension NewGroupViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == mainView.colorCollectionView ? IconStyle.iconTintColor.count : IconStyle.iconSystemImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == mainView.colorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCollectionViewCell.identifier, for: indexPath)
            
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.backgroundColor = IconStyle.iconTintColor[indexPath.item]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCollectionViewCell.identifier, for: indexPath) as! IconCollectionViewCell
            
            cell.iconImageView.image = UIImage(systemName: IconStyle.iconSystemImage[indexPath.item])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        
        if collectionView == mainView.colorCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! BaseCollectionViewCell
            mainView.updateUI(updateImage: nil, updateTintColor: cell.contentView.backgroundColor)
            tintColor = IconStyle.iconTintColor[indexPath.item].toHexString()
            
            cell.contentView.layer.borderColor = UIColor.systemGray6.cgColor
            cell.contentView.layer.borderWidth = 2
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! IconCollectionViewCell
            mainView.updateUI(updateImage: cell.iconImageView.image, updateTintColor: nil)
            systemIcon = IconStyle.iconSystemImage[indexPath.item]
            
            cell.contentView.layer.borderColor = UIColor.systemGray6.cgColor
            cell.contentView.layer.borderWidth = 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        
        let cell = collectionView == mainView.colorCollectionView ? collectionView.cellForItem(at: indexPath) as! BaseCollectionViewCell : collectionView.cellForItem(at: indexPath) as! IconCollectionViewCell
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.borderWidth = 0
    }
    
}
