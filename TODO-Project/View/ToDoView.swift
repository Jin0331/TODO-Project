//
//  ToDoView.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import Then
import SnapKit

enum ToDoViewEnum {
    
    enum leftStack : String,  CaseIterable {
        case today
        case all
        case completed
        
        var title : String {
            switch self {
            case .today :
                return "오늘"
            case .all :
                return "전체"
            case .completed :
                return "완료됨"
            }
        }
        
        var imageString : String {
            switch self {
            case .today :
                return "calendar.circle.fill"
            case .all :
                return "tray.circle.fill"
            case .completed :
                return "checkmark.circle.fill"
            }
        }
        
        var fontColor : UIColor {
            switch self {
            case .today :
                return .systemCyan
            case .all :
                return .systemGray2
            case .completed :
                return .systemGray4
            }
        }
        
    }
    
    enum rightStack : String, CaseIterable {
        case plan
        case flag
        
        var title : String {
            switch self {
            case .plan :
                return "예정"
            case .flag :
                return "깃발 표시"
            }
        }
        
        var imageString : String {
            switch self {
            case .plan :
                return "bookmark.circle.fill"
            case .flag :
                return "flag.circle.fill"
            }
        }
        
        var fontColor : UIColor {
            switch self {
            case .plan :
                return .systemOrange
            case .flag :
                return .systemYellow
            }
        }
    }
}

class ToDoView: BaseView {

    let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = true
    }
    
    let contentsView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let titleLabel = UILabel().then {
        $0.text = "나의 목록"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }

    // StackView 관련
    let outerStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    let leftStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    let leftSubView = ToDoViewEnum.leftStack.allCases.map { eCase in
        let v = ToDoItemView()
        v.transitionButton.layer.name = eCase.rawValue
        v.layer.name = "left"
        
        return v
    }
    
    let rightStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    let rightSubView = ToDoViewEnum.rightStack.allCases.map { eCase in
        let v = ToDoItemView()
        v.layer.name = "right"
        v.transitionButton.layer.name = eCase.rawValue
        
        return v
    }
    
    // Table View
    let groupTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(CommonTableViewCell.self, forCellReuseIdentifier: CommonTableViewCell.identifier)
        $0.rowHeight = 70
        $0.backgroundColor = .clear
        
    }
    
    override func configureHierarchy() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentsView)
        
        [titleLabel, outerStackView, groupTableView].forEach { return contentsView.addSubview($0)}
        
        [leftStackView, rightStackView].forEach { return outerStackView.addArrangedSubview($0)}
        
        leftSubView.forEach { return leftStackView.addArrangedSubview($0)}
        rightSubView.forEach { return rightStackView.addArrangedSubview($0)}

    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaInsets)
        }
        
        contentsView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        outerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(outerStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        groupTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentsView)
            make.height.equalTo(400)
            make.bottom.equalToSuperview().inset(15)
        }
        
    }
    
    override func configureView() {
        super.configureView()
        
        leftSubView.enumerated().forEach { k, v in
            v.setDesign(titleText: ToDoViewEnum.leftStack.allCases[k].title,
                        imageString: ToDoViewEnum.leftStack.allCases[k].imageString,
                        tColor: ToDoViewEnum.leftStack.allCases[k].fontColor,
                        countText: "0")
        }
        
        rightSubView.enumerated().forEach { k, v in
            v.setDesign(titleText: ToDoViewEnum.rightStack.allCases[k].title,
                        imageString: ToDoViewEnum.rightStack.allCases[k].imageString,
                        tColor: ToDoViewEnum.rightStack.allCases[k].fontColor,
                        countText: "0")
        }
    }

}
