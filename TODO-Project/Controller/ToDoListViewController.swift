//
//  ToDoListViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/15/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

//TODO: - View 없이 VC에 바로
class ToDoListViewController: BaseViewController {

    var navigationTitle : String?
    var repository = ToDoTableRepository()
    var dataList : Results<ToDoTable>! {
        didSet {
            mainTableView.reloadData()
        }
    }
    
    let mainTableView = UITableView(frame: .zero).then {
        $0.backgroundColor = .clear
    }
    
    lazy var menuItems: [UIAction] = {
        return
            ToDoTableRepository.sortedKey.allCases.map { item in
                return UIAction(title: item.title, image: UIImage(systemName: item.sortedImage), handler: { _ in
                    self.dataList = self.repository.fetchSort(item.rawValue)})
            }
    }()
    
    lazy var menu: UIMenu = {
        return UIMenu(title: "정렬", options: [], children: menuItems)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        view.addSubview(mainTableView)
    }
    
    override func configureLayout() {
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        mainTableView.rowHeight = 100
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(NewToDoListTableViewCell.self, forCellReuseIdentifier: NewToDoListTableViewCell.identifier)
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = navigationTitle

        let refreshButton = BlockBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain) {
            self.dataList = self.repository.fetch()
        }
        
        let pullDownButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                              menu: menu)
        navigationItem.rightBarButtonItems = [pullDownButton,refreshButton]
    }
}

extension ToDoListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewToDoListTableViewCell.identifier, for: indexPath) as! NewToDoListTableViewCell
        
        cell.receiveData(data: dataList[indexPath.row])
        cell.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        
        
        return cell
    }
    

    
    
    @objc func completeButtonClicked(_ sender : UIButton){
        if let cell = sender.superview?.superview as? NewToDoListTableViewCell, // superview를 이용하여
           let indexPath = mainTableView.indexPath(for: cell){
            
            print(dataList[indexPath.row])
            repository.updateComplete(dataList[indexPath.row])
            mainTableView.reloadData()
        }
    }
}
