//
//  ToDoView.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import Then
import SnapKit

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
    
    let leftSubView = (0..<3).map { _ in return ToDoItemView()}
    
    let rightStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    let rightSubView = (0..<2).map { _ in return ToDoItemView()}
    
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
            
        leftSubView[0].setDesign(titleText: "오늘", imageString: "calendar.circle.fill", tColor: .systemCyan, countText: "0")
        leftSubView[1].setDesign(titleText: "전체", imageString: "tray.circle.fill", tColor: .systemGray2, countText: "0")
        leftSubView[2].setDesign(titleText: "완료됨", imageString: "checkmark.circle.fill", tColor: .systemGray4,countText: "")
        
        rightSubView[0].setDesign(titleText: "예정", imageString: "bookmark.circle.fill", tColor: .systemOrange, countText: "0")
        rightSubView[1].setDesign(titleText: "깃발 표시", imageString: "flag.circle.fill", tColor: .systemYellow, countText: "0")
        
    }

}
