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
    var dataList : Results<ToDoTable>! {
        didSet {
            mainTableView.reloadData()
        }
    }
    
    let mainTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
    }
    
    lazy var menuItems: [UIAction] = {
        return [
            UIAction(title: "제목", image: UIImage(systemName: "arrow.clockwise.square"), handler: { _ in
                let realm = try! Realm()
                self.dataList = realm.objects(ToDoTable.self).sorted(byKeyPath: "title", ascending: true)
            }),
            UIAction(title: "마감일", image: UIImage(systemName: "arrow.clockwise.square"), handler: { _ in
                let realm = try! Realm()
                self.dataList = realm.objects(ToDoTable.self).sorted(byKeyPath: "endDate", ascending: true)
            }),
            UIAction(title: "우선순위 높음", image: UIImage(systemName: "arrow.clockwise.square"), handler: { _ in
                let realm = try! Realm()
                self.dataList =  realm.objects(ToDoTable.self).where {
                    $0.priority == "2"
                }
            }),
            UIAction(title: "우선순위 낮음", image: UIImage(systemName: "arrow.clockwise.square"), handler: { _ in
                let realm = try! Realm()
                self.dataList =  realm.objects(ToDoTable.self).where {
                    $0.priority == "0"
                }
            }),
        ]
    }()
    
    lazy var menu: UIMenu = {
        return UIMenu(title: "정렬", options: [], children: menuItems)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        dataList = realm.objects(ToDoTable.self)

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
        mainTableView.rowHeight = 70
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(BaseTableSystemViewCell.self, forCellReuseIdentifier: "mainCell")
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = navigationTitle

        let refreshButton = BlockBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain) {
            let realm = try! Realm()
            self.dataList = realm.objects(ToDoTable.self)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell")!
        
        let row = dataList[indexPath.row]
        var subTitle : String
        
        cell.textLabel?.text = row.title
        
        if let memo = row.memo {
            subTitle = [memo, "\(row.endDateFormatting)까지", row.tag].joined(separator: " | ")
            cell.detailTextLabel?.text = subTitle
        } else {
            subTitle = ["\(row.endDateFormatting)까지", row.tag].joined(separator: " | ")
            cell.detailTextLabel?.text = subTitle
        }
        
        return cell
    }
    
    
}
