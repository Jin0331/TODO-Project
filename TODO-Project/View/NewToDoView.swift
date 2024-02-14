//
//  NewToDoView.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import SnapKit
import Then

//TODO: - Navigation controller 추가, cancle / 추가 버튼(항목이 채워져야 활성화되도록)

class NewToDoView : BaseView {
    
    let topView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let titleTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "제목",
                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2,
                                                                   NSAttributedString.Key.font: UIFont(name: "Georgia", size: 16)!])
        $0.backgroundColor = .clear
    }
    
    
    let memoTextView = UITextView().then {
        $0.text = "메모"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .systemGray2
        $0.backgroundColor = .clear
    }
    
    let bottomStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    
    let subItemView = (0..<4).map { index in
        
        let subView = ItemView()
        subView.rightButton.tag = index
        
        return subView
    }
    
//    let testView = ItemView().then {
//        $0.textLabel.text = "마감일"
//    }
    override func configureHierarchy() {
        addSubview(topView)
        [titleTextField, memoTextView].forEach { return addSubview($0)}
        
        addSubview(bottomStackView)
        subItemView.forEach { return bottomStackView.addArrangedSubview($0)}
    }
    
    override func configureLayout() {
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(200)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).inset(5)
            make.horizontalEdges.equalTo(topView).inset(15)
            make.height.equalTo(topView).multipliedBy(0.25)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(3)
            make.leading.equalTo(titleTextField)
            make.trailing.equalTo(topView).inset(5)
            make.height.equalTo(topView).multipliedBy(0.75)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(topView)
            make.height.equalTo(270)
        }
        
//        testView.snp.makeConstraints { make in
//            make.top.equalTo(topView.snp.bottom).offset(20)
//            make.horizontalEdges.equalTo(topView)
//            make.height.equalTo(60)
//        }
        
    }
    
    override func configureView() {
        super.configureView()

        let titleArray : [String] = ["마감일", "태그", "우선 순위", "이미지 추가"]
        
        for (index, value) in titleArray.enumerated() {
            subItemView[index].setTitle(value: value)
        }
    }
    
}
