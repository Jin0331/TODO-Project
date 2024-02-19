//
//  BaseViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        configureNavigation()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        
        view.backgroundColor = .black
    }

    // navigation controller가 있다면 적용되는 사항
    func configureNavigation() {
        // 배경색
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        navigationController?.toolbar.scrollEdgeAppearance?.backgroundColor = .black
        navigationController?.toolbar.barTintColor = UIColor.black
        
        // title
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .heavy)
        ]
        navigationItem.title = ""
        
        // back button
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }

}
