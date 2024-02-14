//
//  ViewController.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit

class ToDoViewController: BaseViewController {

    let mainView = ToDoView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    override func configureView() {
        var items : [UIBarButtonItem] = []
        
        //TODO: - image와 label 추가하려면 UIButton 이용해서 Custom,으로 제작해야 됨. ---> 나중에
        let leftToolbarItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(leftToolbarItemClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let rightToolbarItem = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(rightToolbarItemClicked))
        
        items.append(leftToolbarItem)
        items.append(flexibleSpace)
        items.append(rightToolbarItem)

        mainView.toolBar.setItems(items, animated: true)
    }
    
    @objc func leftToolbarItemClicked(_ sender : UIButton) {
        print(#function)
        
        let vc = NewToDoViewController()
        
        present(vc, animated: true)
    }
    
    //MARK: - 목록추가는 나중에 구현하는 듯???
    @objc func rightToolbarItemClicked(_ sender : UIButton) {
        print(#function)
    }

    

}

