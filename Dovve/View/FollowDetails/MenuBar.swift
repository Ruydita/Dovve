//
//  MenuBar.swift
//  Dovve
//
//  Created by Dheeraj Kumar Sharma on 27/09/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class MenuBar:UIView {
    
    var horizontalBarLeadingAnchorConstraints:NSLayoutConstraint?
    var followDetailController:FollowDetailViewController?
    
    let collectionView:UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.dynamicColor(.appBackground)
        return cv
    }()
    
    let seperatorView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.dynamicColor(.secondaryBackground)
        return v
    }()
    
    let selectedBarView:UIView = {
        let v = UIView()
        v.backgroundColor = CustomColors.appBlue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(FollowMenuCollectionViewCell.self, forCellWithReuseIdentifier: "FollowMenuCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        backgroundColor = UIColor.dynamicColor(.appBackground)
        addSubview(collectionView)
        addSubview(seperatorView)
        addSubview(selectedBarView)
        collectionView.pin(to: self)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        horizontalBarLeadingAnchorConstraints = selectedBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        horizontalBarLeadingAnchorConstraints?.isActive = true
        selectedBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        selectedBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        selectedBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowMenuCollectionViewCell", for: indexPath) as! FollowMenuCollectionViewCell
        if indexPath.row == 0{
            cell.followLabel.text = "Followers"
        }
        if indexPath.row == 1{
            cell.followLabel.text = "Following"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width / 2, height: frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        followDetailController?.scrollToMenuIndex(indexPath.row, true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
