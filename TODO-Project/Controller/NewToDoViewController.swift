//
//  NewTodoViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit

class NewToDoViewController: BaseViewController {

    let mainView = NewToDoView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.subItemView[0].rightButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
    }
    
    override func configureView() {
//        mainView.subItemView[0].rightButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
    }
    
    @objc func rightButtonClicked(_ sender : UIButton) {
        
        print(#function)
        print(sender.tag)
                
        switch sender.tag {
        case 0 :
            let vc = DateViewController()
            print(vc, " 핫둘핫둘")
//            navigationController?.pushViewController(vc, animated: true)
            present(vc, animated: true)
        default :
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
