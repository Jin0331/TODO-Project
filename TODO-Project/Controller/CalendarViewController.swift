//
//  CalendarViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/19/24.
//

import UIKit
import SnapKit
import Then
import FSCalendar
import RealmSwift

class CalendarViewController: BaseViewController {

    var notificationToken: NotificationToken?
    var dataList : Results<ToDoTable>!
    var repository = RealmRepository()
    let format = DateFormatter().then {
        $0.dateFormat = "yyyy년 MM월 dd일 hh시"
    }
    
    let calendarView = FSCalendar().then {
        $0.appearance.titleDefaultColor = UIColor.white
        $0.appearance.titlePlaceholderColor = UIColor.white.withAlphaComponent(0.2)
        $0.appearance.headerDateFormat = "YYYY년 MM월"
        $0.scrollDirection = .vertical
        $0.locale = Locale(identifier: "ko_KR")
        
        //❗️ 캘린더 나타날때, 오늘 날짜로 표현하도록.. default로 설정되어 있지만, 추후 수정이 필요할 경우 사용하면 될 듯
        $0.select(Date(), scrollToDate: true)
    }
    let mainTableView = UITableView(frame: .zero).then {
        $0.backgroundColor = .clear
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기값, // 완료되지 않은 할일 목록에서, date가 nil이 아닌 값, 오늘날짜
        let start = Calendar.current.startOfDay(for: Date())
        let end : Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "endDate >= %@ && endDate < %@", start as NSDate, end as NSDate)
        
        dataList = repository.fetchAll().where{$0.endDate != nil}.filter(predicate)
    }
    
    override func configureHierarchy() {
        view.addSubview(calendarView)
        view.addSubview(mainTableView)
    }
    
    override func configureLayout() {
        calendarView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        calendarView.delegate = self
        calendarView.dataSource = self
        
        mainTableView.rowHeight = 100
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(NewToDoListTableViewCell.self, forCellReuseIdentifier: NewToDoListTableViewCell.identifier)
    }
}


//MARK: - Calendar
//TODO: - 완료목록, 할일목록 분기처리도 가능할 듯. -> FSCalendarDelegateAppearance,, https://snowee.tistory.com/30
extension CalendarViewController : FSCalendarDelegate, FSCalendarDataSource {
    
    //MARK: - 우선 할일목록만 Dot으로 표현
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let start = Calendar.current.startOfDay(for: date) // 클릭된 시점의 해당 시간
        let end : Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "endDate >= %@ && endDate < %@", start as NSDate, end as NSDate)
        
        return repository.fetchAll().where{$0.endDate != nil}.filter(predicate).count

    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let start = Calendar.current.startOfDay(for: date) // 클릭된 시점의 해당 시간
        let end : Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "endDate >= %@ && endDate < %@", start as NSDate, end as NSDate)
        
        dataList = repository.fetchAll().where{$0.endDate != nil}.filter(predicate)
        
        mainTableView.reloadData()
    }
}

//MARK: - tableView, 수정기능은 추가하지 않았음.
extension CalendarViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewToDoListTableViewCell.identifier, for: indexPath) as! NewToDoListTableViewCell
        cell.receiveData(data: dataList[indexPath.row])
        cell.rightImageView.image = loadImageToDocument(pk: dataList[indexPath.row]._id.stringValue)

        return cell
    }
}
