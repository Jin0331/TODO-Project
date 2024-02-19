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
    
    let rightButtonImageView = UIImageView().then { _ in
    }
    
    let rightImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let labelButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(.clear, for: .normal)
    }
    
    override func configureHierarchy() {
        addSubview(textLabel)
        addSubview(subLabel)
        addSubview(rightButtonImageView)
        addSubview(rightImageView)
        addSubview(labelButton)
    }
    
    override func configureLayout() {
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(100)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(textLabel.snp.trailing)
            make.trailing.equalTo(rightButtonImageView.snp.leading)
        }
        
        rightButtonImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(15)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        
        labelButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
