//
//  ToDoItemView.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/15/24.
//

import UIKit
import SnapKit
import Then

class ToDoItemView: BaseView {

    let titleImageView = UIImageView().then {
        $0.tintColor = .red
        $0.image = UIImage(systemName: "circle.circle.fill")
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .systemGray2
        $0.text = "오늘"
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    let countLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "0"
        $0.font = .systemFont(ofSize: 35, weight: .heavy)
    }
    
    override func configureHierarchy() {
        [titleImageView, titleLabel, countLabel].forEach { return addSubview($0)}
    }
    
    override func configureLayout() {
        titleImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(10)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.leading.equalTo(safeAreaLayoutGuide).inset(10)
            make.width.equalTo(100)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureView() {
        backgroundColor = .darkGray
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func setDesign(titleText : String, imageString : String, tColor : UIColor, countText : String) {
        titleLabel.text = titleText
        titleImageView.image = UIImage(systemName: imageString)
        titleImageView.tintColor = tColor
        countLabel.text = countText
    }

}
