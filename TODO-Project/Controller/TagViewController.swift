//
//  TagViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import SnapKit
import Then

class TagViewController: BaseViewController {
    
    var tagTextFieldSpace : ((String) -> Void)?
    
    let tagTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "태그를 입력하세요",
                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2,
                                                                   NSAttributedString.Key.font: UIFont(name: "Georgia", size: 16)!])
        $0.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTextField.addTarget(self, action: #selector(tagTextFieldEditingDidEnd), for: .editingDidEnd)

    }
    
    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
    @objc func tagTextFieldEditingDidEnd(_ sender : UITextField) {
        tagTextFieldSpace?(sender.text!)
    }

}
