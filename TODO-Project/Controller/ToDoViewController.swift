//
//  ViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit

class ToDoViewController: BaseViewController {
    
    let mainView = ToDoView()
    let repository = ToDoTableRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        countUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.leftSubView.forEach {
            return $0.transitionButton.addTarget(self, action: #selector(transitionButtonClicked), for: .touchUpInside)
        }
        
        mainView.rightSubView.forEach {
            return $0.transitionButton.addTarget(self, action: #selector(transitionButtonClicked), for: .touchUpInside)
        }
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationController?.isToolbarHidden = false
        
        var items : [UIBarButtonItem] = []
        
        //TODO: - image와 label 추가하려면 UIButton 이용해서 Custom,으로 제작해야 됨. ---> 나중에
        let leftToolbarItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(leftToolbarItemClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let rightToolbarItem = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(rightToolbarItemClicked))
        
        items.append(leftToolbarItem)
        items.append(flexibleSpace)
        items.append(rightToolbarItem)
        
        toolbarItems = items
    }
    
    @objc func leftToolbarItemClicked(_ sender : UIButton) {
        print(#function)
        
        let vc =  NewToDoViewController()
        vc.countUpdate = {
            self.countUpdate()
        }
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc func transitionButtonClicked(_ sender : UIButton) {
        
//        print(#function, sender.superview?.layer.name)
        
        guard let superViewName = sender.superview?.layer.name else { return }
        guard let eCaseRawValue = sender.layer.name else { return }
        
        if superViewName == "left" {
            switch ToDoViewEnum.leftStack(rawValue: eCaseRawValue) {
            case .all :
                print("hihi - all 전체") //TODO: - Navigation transition
                
                let vc = ToDoListViewController()
                vc.navigationTitle = "전체"
                vc.dataList = repository.fetchAll()
                
                navigationController?.pushViewController(vc, animated: true)
                
            case .completed :
                let vc = ToDoListViewController()
                vc.navigationTitle = "완료"
                vc.dataList = repository.fetchComplete()
                
                navigationController?.pushViewController(vc, animated: true)
            default :
                print("아직 구현 아니야~!")
            }
            
        }
        
        
    }
    
    //MARK: - 목록추가는 나중에 구현하는 듯???
    @objc func rightToolbarItemClicked(_ sender : UIButton) {
        print(#function)
    }
    
    func countUpdate() {
        //TODO: - Date filter 방법 찾아야됨.
//        mainView.leftSubView[0].countLabel.text = String(repository.fetchNowDate().count) // 오늘
        mainView.leftSubView[1].countLabel.text = String(repository.fetchAll().count) // 전체
        mainView.leftSubView[2].countLabel.text = String(repository.fetchComplete().count) // 완료
        
        mainView.rightSubView[1].countLabel.text = String(repository.fetchFlag().count) // 깃발
        
    }
    
    
}

