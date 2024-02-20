//
//  CommonCollectionViewCell.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/20/24.
//

import UIKit
import SnapKit
import Then

class IconCollectionViewCell: BaseCollectionViewCell {
    
    let iconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "flag")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(10)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .systemGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
}
