//
//  GroupViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/21/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class GroupViewController: BaseViewController {
    
    //MARK: - View
    let headerLabel = UILabel().then {
        $0.text = "Realm Table"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 17, weight: .bold)
    }
    let groupTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(CommonTableViewCell.self, forCellReuseIdentifier: CommonTableViewCell.identifier)
        $0.rowHeight = 70
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
    }
    override func configureHierarchy() {
        [headerLabel, groupTableView].forEach { view.addSubview($0)}
    }
    override func configureLayout() {
        
        headerLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.height.equalTo(30)
        }
        
        groupTableView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    //MARK: - Controller
    var navTitle : String?
    let repository = RealmRepository()
    var taskGroupList : Results<TaskGroup>!
    var taskGroupListSender : ((TaskGroup) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskGroupList = repository.fetch()
    }
    
    override func configureView() {
        super.configureView()
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        if let navTitle {
            navigationItem.title = navTitle
        }
    }
    
}

extension GroupViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskGroupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonTableViewCell.identifier, for: indexPath) as! CommonTableViewCell
        
        cell.backgroundColor = .clear
        cell.countLabel.text = ""
        cell.selectionStyle = .gray
        
        let row = taskGroupList[indexPath.row]
        cell.receiveData(data: row)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(#function)
        let row = taskGroupList[indexPath.row]
        
        taskGroupListSender?(row)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    // insetgroup 여백관련
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { UIView() }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { .leastNormalMagnitude }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { .leastNormalMagnitude }
}
