//
//  NewGroup.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/20/24.
//

import UIKit
import SnapKit
import Then

class NewGroup : BaseView {
    
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .red
    }
    
    let contentsView = UIView().then {
        $0.backgroundColor = .green
    }
    
    // first View
    let topView = UIView().then {
        $0.backgroundColor = .yellow
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let iconImage = UIImageView().then {
        $0.image = UIImage(systemName: "flag")
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .systemBlue
    }
    
    let groupNameTextfield = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "목록 이름",
                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2,
                                                                   NSAttributedString.Key.font: UIFont(name: "Georgia", size: 20)!])
        
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
        $0.backgroundColor = .systemGray
    }
    
    
    // color select
    let colorView = UIView().then {
        $0.backgroundColor = .purple
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var colorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Systemcell")
        
        return collectionView
    }()
    
    // color select
    let iconView = UIView().then {
        $0.backgroundColor = .blue
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var iconCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Systemcell")
        
        return collectionView
    }()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentsView)
        
        [topView, colorView, iconView].forEach { contentsView.addSubview($0)}
        
        // topView
        [iconImage, groupNameTextfield].forEach { topView.addSubview($0)}
        
        // collectionviews
        colorView.addSubview(colorCollectionView)
        iconView.addSubview(iconCollectionView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentsView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView.snp.width)
        }

        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(180)
        }
        
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(topView.snp.height).multipliedBy(0.55)
        }
        
        groupNameTextfield.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
            make.height.equalTo(topView.snp.height).multipliedBy(0.3)
        }
        
        colorView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(topView)
            make.height.equalTo(800)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.layer.cornerRadius = 10
    }
}
