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

//        let refreshButton = BlockBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain) {
//            self.dataList = self.repository.fetchAll()
////            self.mainTableView.reloadData()
//        }
        
        let pullDownButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                              menu: menu)
//        navigationItem.rightBarButtonItems = [pullDownButton,refreshButton]
        navigationItem.rightBarButtonItems = [pullDownButton]
    }
}

//MARK: - tableView delegate, datasource
extension ToDoListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewToDoListTableViewCell.identifier, for: indexPath) as! NewToDoListTableViewCell
        
        cell.receiveData(data: dataList[indexPath.row])
        cell.rightImageView.image = loadImageToDocument(filename: dataList[indexPath.row]._id.stringValue)
        cell.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func completeButtonClicked(_ sender : UIButton){
        if let cell = sender.superview?.superview as? NewToDoListTableViewCell, // superview를 이용하여
           let indexPath = mainTableView.indexPath(for: cell){
            
            repository.updateComplete(dataList[indexPath.row])
            mainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flag = UIContextualAction(style: .normal, title: "깃발") {action, view, completionHandler in
            
            self.repository.updateFlag(self.dataList[indexPath.row])
            print(self.dataList[indexPath.row])
            completionHandler(true)
        }

        // weak self : 클로져 내부에서 self 를 사용할 때 strong reference cycle 예방
        let delete = UIContextualAction(style: .normal, title: "삭제") {action, view, completionHandler in

            // 삭제 처리
            self.repository.removeItem(self.dataList[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }

        flag.backgroundColor = .orange
        delete.backgroundColor = .red

        let config = UISwipeActionsConfiguration(actions: [delete,flag])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = dataList[indexPath.row]
        let vc = DetailToDoViewController()
        
        //TODO: - vc.dataList는 Result타입이 아닌, ToDoTable
        
        vc.dataList = row
        vc.tableViewReload = {
            self.mainTableView.reloadData()
        }
        
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
