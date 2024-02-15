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

    let titleLabel = UILabel().then {
        $0.text = "전체"
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 40, weight: .bold)
    }

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
    
    override func configureHierarchy() {
        
        [titleLabel, outerStackView].forEach { return addSubview($0)}
        
        [leftStackView, rightStackView].forEach { return outerStackView.addArrangedSubview($0)}
        
        leftSubView.forEach { return leftStackView.addArrangedSubview($0)}
        rightSubView.forEach { return rightStackView.addArrangedSubview($0)}

    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        outerStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
            make.height.equalTo(300)
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
