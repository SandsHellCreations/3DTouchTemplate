//
//  CollectionDataSource.swift
//  3DTouchTemplate
//
//  Created by Sandeep Kumar on 01/10/18.
//  Copyright © 2018 Sandeep Kumar. All rights reserved.
//

import UIKit

typealias ConfigureCell = (_ cell: UICollectionViewCell, _ indexPath: IndexPath, _ item: Any?) -> ()
typealias DidSelectItem = (_ indexPath: IndexPath) -> ()

struct CollectionSize {
    var size = CGSize.zero
    var edgeInsets = UIEdgeInsets.zero
    var lineSpacing = CGFloat()
    var interItemSpacing = CGFloat()
    
    init(_ size: CGSize, _ edgeInset: UIEdgeInsets, _ lineSpacing: CGFloat, _ itemSpacing: CGFloat) {
        self.size = size
        self.edgeInsets = edgeInset
        self.lineSpacing = lineSpacing
        self.interItemSpacing = itemSpacing
    }
}

enum ScreenSize: Int {
    case WIDTH
    case HEIGHT
    
    var value: CGFloat {
        switch self {
        case .WIDTH: return UIScreen.main.bounds.width
        case .HEIGHT: return UIScreen.main.bounds.height
        }
    }
    
    func cellHeightWidth(by itemSpacing: CGFloat, noOfItems: Int, sideSpacing: CGFloat) -> CGFloat {
        let valueToBeSubtracted = (sideSpacing * 2) + (itemSpacing * CGFloat(noOfItems - 1))
        let totalWidthOrHeight = self.value - valueToBeSubtracted
        let cellWidthHeight = totalWidthOrHeight / CGFloat(noOfItems)
        return cellWidthHeight
    }
}

class CollectionDataSource: NSObject {
    //MARK:- Variables
    var items: [Any]?
    var cellIdentifier: String?
    var configureCell: ConfigureCell?
    var didSelectItem: DidSelectItem?
    var collectionSize: CollectionSize?
    
    //MARK:- Initializer
    init(items: [Any]?, identifier: String, collectionSize: CollectionSize?) {
        self.items = items
        self.cellIdentifier = identifier
        self.collectionSize = collectionSize
    }
}

//MARK:- UICollectionView DataSource
extension CollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier ?? "", for: indexPath)
        configureCell?(cell, indexPath, items?[indexPath.row])
        return cell
    }
}

//MARK:- UICollectionViewDelegate
extension CollectionDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath)
    }
}

//MARK:- UICollectionViewFlowLayoutDelegate
extension CollectionDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionSize?.size ?? CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionSize?.edgeInsets ?? UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionSize?.lineSpacing ?? CGFloat()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionSize?.interItemSpacing ?? CGFloat()
    }
}
