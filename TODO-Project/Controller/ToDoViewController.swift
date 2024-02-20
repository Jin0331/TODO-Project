//
//  ViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import RealmSwift

class ToDoViewController: BaseViewController {
    
    let mainView = ToDoView()
    let repository = RealmRepository()
    var groupList : Results<TaskGroup>!
    
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
        
        // stackView
        mainView.leftSubView.forEach {
            return $0.transitionButton.addTarget(self, action: #selector(transitionButtonClicked), for: .touchUpInside)
        }
        
        mainView.rightSubView.forEach {
            return $0.transitionButton.addTarget(self, action: #selector(transitionButtonClicked), for: .touchUpInside)
        }
        
        // tableView
        groupList = repository.fetch()
    }
    
    override func configureView() {
        mainView.groupTableView.delegate = self
        mainView.groupTableView.dataSource = self
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
        let vc = ToDoListViewController() // 전환되는 vc
        
        if superViewName == "left" {
            
            guard let eCaseLeftStack = ToDoViewEnum.leftStack(rawValue: eCaseRawValue) else { print("leftStacError");return }
            
            vc.navigationTitle = eCaseLeftStack.title
            
            switch eCaseLeftStack {
            case .all :
                vc.dataList = repository.fetchAll()
            case .completed :
                vc.dataList = repository.fetchComplete()
            case .today :
                vc.dataList = repository.fetchToday()
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if superViewName == "right" {
            
            guard let eCaseRightStack = ToDoViewEnum.rightStack(rawValue: eCaseRawValue) else { print("rightStacError");return }
            
            vc.navigationTitle = eCaseRightStack.title
            
            switch eCaseRightStack {
            case .plan :
                vc.dataList = repository.fetchTomorrow()
            case .flag :
                vc.dataList = repository.fetchFlag()
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - 목록추가는 나중에 구현하는 듯???
    @objc func rightToolbarItemClicked(_ sender : UIButton) {
        
        let vc =  NewGroupViewController()
        vc.uiUpdate = {
            self.mainView.groupTableView.reloadData()
        }
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }
    
    func countUpdate() {
        //TODO: - Date filter 방법 찾아야됨.
        //TODO: - 여기 리팩토링은 어케????
        mainView.leftSubView[0].countLabel.text = String(repository.fetchToday().count) // 오늘
        mainView.leftSubView[1].countLabel.text = String(repository.fetchAll().count) // 전체
        mainView.leftSubView[2].countLabel.text = String(repository.fetchComplete().count) // 완료
        
        mainView.rightSubView[0].countLabel.text = String(repository.fetchTomorrow().count) // 예정
        mainView.rightSubView[1].countLabel.text = String(repository.fetchFlag().count) // 깃발
    }
}

extension ToDoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonTableViewCell.identifier, for: indexPath) as! CommonTableViewCell

        let row = groupList[indexPath.row]
        
        cell.receiveData(data: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ToDoListViewController() // 전환되는 vc
        vc.superDataList = groupList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    // insetgroup 여백관련
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { UIView() }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { .leastNormalMagnitude }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { .leastNormalMagnitude }
}
