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

    let toolBar = UIToolbar().then {
        $0.barTintColor = .red
        
    }
    
    override func configureHierarchy() {
        
        addSubview(toolBar)
    }
    
    override func configureLayout() {
        toolBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
    }

}
