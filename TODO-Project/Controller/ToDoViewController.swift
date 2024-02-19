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
        
        // navigation
        let leftNavigationItem = UIBarButtonItem(image: UIImage(systemName: "calendar.circle"), style: .plain, target: self, action: #selector(leftNavigationItemClicked))
        leftNavigationItem.tintColor = .systemPink
        
        navigationItem.leftBarButtonItem = leftNavigationItem
        
        // toolbar
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
    
    @objc func leftNavigationItemClicked(_ sender : UIButton) {
        print(#function)
        
        let vc = CalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
        
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
                
        guard let superViewName = sender.superview?.layer.name else { return }
        guard let eCaseRawValue = sender.layer.name else { return }
        
        if superViewName == "left" {
            switch ToDoViewEnum.leftStack(rawValue: eCaseRawValue) {
            case .all :
                let vc = ToDoListViewController()
                vc.navigationTitle = "전체"
                vc.dataList = repository.fetchAll()
                navigationController?.pushViewController(vc, animated: true)
                
            case .completed :
                let vc = ToDoListViewController()
                vc.navigationTitle = "완료"
                vc.dataList = repository.fetchComplete()
                navigationController?.pushViewController(vc, animated: true)
            case .today :
                let vc = ToDoListViewController()
                vc.navigationTitle = "오늘"
                vc.dataList = repository.fetchToday()
                navigationController?.pushViewController(vc, animated: true)
            default :
                print("error")
            }
        } else if superViewName == "right" {
            switch ToDoViewEnum.rightStack(rawValue: eCaseRawValue) {
            case .plan :
                let vc = ToDoListViewController()
                vc.navigationTitle = "예정"
                vc.dataList = repository.fetchTomorrow()
                navigationController?.pushViewController(vc, animated: true)
            case .flag :
                let vc = ToDoListViewController()
                vc.navigationTitle = "깃발"
                vc.dataList = repository.fetchFlag()
                navigationController?.pushViewController(vc, animated: true)
            default :
                print("error")
                
            }
        }
        
        
    }
    
    //MARK: - 목록추가는 나중에 구현하는 듯???
    @objc func rightToolbarItemClicked(_ sender : UIButton) {
        print(#function)
    }
    
    func countUpdate() {
        //TODO: - Date filter 방법 찾아야됨.
        mainView.leftSubView[0].countLabel.text = String(repository.fetchToday().count) // 오늘
        mainView.leftSubView[1].countLabel.text = String(repository.fetchAll().count) // 전체
        mainView.leftSubView[2].countLabel.text = String(repository.fetchComplete().count) // 완료
        
        mainView.rightSubView[0].countLabel.text = String(repository.fetchTomorrow().count) // 예정
        mainView.rightSubView[1].countLabel.text = String(repository.fetchFlag().count) // 깃발
        
    }
    
    
}

