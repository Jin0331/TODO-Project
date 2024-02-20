//
//  BaseCollectionViewCell.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/20/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        
    }
    
    func configureHierarchy() {
        
    }
    
    func configureView() {
        
    }
}
