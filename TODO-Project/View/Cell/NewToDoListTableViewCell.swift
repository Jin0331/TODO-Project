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

    let completeImage = UIImageView().then { _ in
    }
    
    let completeButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setTitleColor(.clear, for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.backgroundColor = .black
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    let outerStackView = UIStackView().then {
        $0.backgroundColor = .red
        $0.axis = .vertical
        $0.distribution = .fillProportionally
    }
    
    let innerStackView = UIStackView().then {
        $0.backgroundColor = .blue
        $0.axis = .vertical
        $0.distribution = .fillProportionally
    }

}
