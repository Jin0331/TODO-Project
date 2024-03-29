//
//  NewToDoListTableViewCell.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/18/24.
//

import UIKit
import SnapKit
import Then

class NewToDoListTableViewCell: BaseTableViewCell {
    
    
    let completeImage = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
        $0.tintColor = .systemGray
    }
    
    let completeButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setTitleColor(.clear, for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "타이틀입니다"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    let rightImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let outerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    let memoLabel = UILabel().then {
        $0.text = "메모입니다"
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 12)
    }
    
    let innerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2024.13.132024.13.132024.13.13"
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 12)
    }
    
    let tagLabel = UILabel().then {
        $0.text = "#tag"
        $0.textColor = .systemBlue
        $0.font = .systemFont(ofSize: 12)
    }
    
    override func configureHierarchy() {
        
        [completeImage, completeButton, titleLabel, rightImageView, outerStackView].forEach {
            contentView.addSubview($0)
        }
        
        outerStackView.addArrangedSubview(memoLabel)
        outerStackView.addArrangedSubview(innerStackView)
        [dateLabel, tagLabel].forEach {
            return innerStackView.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        completeImage.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.size.equalTo(20)
        }
        
        completeButton.snp.makeConstraints { make in
            make.edges.equalTo(completeImage)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(completeImage.snp.top)
            make.leading.equalTo(completeImage.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(20)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
        
        outerStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(rightImageView.snp.leading)
            make.height.equalTo(50)
        }
    }

    override func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func receiveData(data : ToDoTable) {
        
        if data.completed == true {
            completeImage.image = UIImage(systemName: "circle.inset.filled")
        } else {
            completeImage.image = UIImage(systemName: "circle")
        }
        
        if let priority = data.priority {
            let priorityEmoji = String(repeating: "❗️", count: Int(priority)! + 1)
            titleLabel.text = priorityEmoji + data.title
        } else {
            titleLabel.text = data.title
        }
        
        if let memo = data.memo, memo.count > 0 {
            memoLabel.text = memo
        } else {
            memoLabel.isHidden = true
        }
        
        if let endDate = data.endDate {
            dateLabel.text = endDate.toString(dateFormat: "yy/MM/dd")
        } else {
            dateLabel.isHidden = true
        }
        
        if let tag = data.tag {
            tagLabel.text = " #" + tag
        } else {
            tagLabel.isHidden = true
        }
    }
    
    
}
