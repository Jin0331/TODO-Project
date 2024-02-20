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
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = true
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
        collectionView.backgroundColor = .red
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
        
        collectionView.backgroundColor = .red
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
            make.edges.equalTo(safeAreaInsets)
        }
        
        contentsView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }

        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(200)
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
            make.height.equalTo(200)
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(colorView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(topView)
            make.height.equalTo(400)
            make.bottom.equalToSuperview().inset(15) //여기가 핵심이군.. 마지막 View는 Bottom을 확실히 해줘야 한다.
        }
        
        iconCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.layer.cornerRadius = 10
    }
}
