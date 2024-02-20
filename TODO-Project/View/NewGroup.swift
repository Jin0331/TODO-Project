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
        $0.backgroundColor = .clear
    }
    
    // first View
    let topView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let iconImage = UIImageView().then {
        $0.image = UIImage(systemName: "square.and.arrow.up.circle")
        $0.contentMode = .scaleAspectFill
    }
    
    let groupNameTextfield = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "목록 이름",
                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2,
                                                                   NSAttributedString.Key.font: UIFont(name: "Georgia", size: 23)!])
        
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
        $0.backgroundColor = .systemGray
    }
    
    
    // color select
    let colorView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var colorCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCellLayout())
        
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = false
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    // color select
    let iconView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var iconCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCellLayout())
        
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.allowsMultipleSelection = false
        collectionView.register(IconCollectionViewCell.self, forCellWithReuseIdentifier: IconCollectionViewCell.identifier)
        
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
            make.height.equalTo(170)
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(colorView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(topView)
            make.height.equalTo(500)
            make.bottom.equalToSuperview().inset(15) //여기가 핵심이군.. 마지막 View는 Bottom을 확실히 해줘야 한다.
        }
        
        iconCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
    
    private func configureCellLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let rowCount : Double = 6
        let sectionSpacing : CGFloat = 5
        let itemSpacing : CGFloat = 3
        let width : CGFloat = UIScreen.main.bounds.width - (itemSpacing * (rowCount - 1)) - (sectionSpacing * 2)
        let itemWidth: CGFloat = width / rowCount
        
        // 각 item의 크기 설정 (아래 코드는 정사각형을 그린다는 가정)
        layout.itemSize = CGSize(width: itemWidth , height: itemWidth)
        // 스크롤 방향 설정
        layout.scrollDirection = .vertical
        // Section간 간격 설정
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        // item간 간격 설정
        layout.minimumLineSpacing = itemSpacing        // 최소 줄간 간격 (수직 간격)
        layout.minimumInteritemSpacing = itemSpacing   // 최소 행간 간격 (수평 간격)
        
        return layout
    }
    
    func updateUI(updateImage : UIImage?, updateTintColor : UIColor?) {
        
        if let updateImage {
            print("실행되나요?")
            iconImage.image = updateImage
        }
        
        if let updateTintColor {
            iconImage.tintColor = updateTintColor
            groupNameTextfield.textColor = updateTintColor
        }
    }
}
