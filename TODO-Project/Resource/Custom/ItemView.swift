//
//  ItemView.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import SnapKit
import Then

class ItemView : BaseView {
    let textLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
    }
    
    let subLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .systemGray2
        $0.textAlignment = .right
    }
    
    let rightButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .systemGray2
    }
    
    override func configureHierarchy() {
        addSubview(textLabel)
        addSubview(subLabel)
        addSubview(rightButton)
    }
    
    override func configureLayout() {
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(100)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(rightButton.snp.leading)
            make.width.equalTo(150)
        }
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(30)
        }
        
    }
    
    override func configureView() {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .darkGray
    }
    
    func setTitle(value : String) {
        textLabel.text = value
    }
}
