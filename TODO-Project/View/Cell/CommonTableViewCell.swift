//
//  CommonTableViewCell.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/21/24.
//

import UIKit
import SnapKit
import Then


class CommonTableViewCell: BaseTableViewCell {

    let iconImage = UIImageView().then {
        $0.image = UIImage(systemName: "square.and.arrow.up.circle")
        $0.contentMode = .scaleAspectFill
//        $0.backgroundColor = .red
    }
    
    let groupNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    
    let countLabel = UILabel().then {
        $0.textColor = .systemGray3
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }

    
    override func configureHierarchy() {
        [iconImage, groupNameLabel, countLabel].forEach { contentView.addSubview($0)}
    }
    
    override func configureLayout() {
        iconImage.snp.makeConstraints { make in
            make.size.equalTo(contentView.safeAreaLayoutGuide.snp.height).multipliedBy(0.7)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        groupNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(iconImage.snp.trailing).offset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
//            make.width.equalTo(100)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(25)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .darkGray
        selectionStyle = .none
    }
    
    func receiveData(data :TaskGroup ) {
        groupNameLabel.text = data.groupName
        countLabel.text = "\(data.todo.count)"
        
        if let icon = data.icon?.systemIcon, let hex = data.icon?.colorHex {
            iconImage.image = UIImage(systemName: icon)
            iconImage.tintColor = UIColor(hex: hex)
        }
    }
}
