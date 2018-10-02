//
//  MainVC.swift
//  3DTouchTemplate
//
//  Created by Sandeep Kumar on 01/10/18.
//  Copyright © 2018 Sandeep Kumar. All rights reserved.
//

import UIKit


class MainVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:-Variables
    var dataSource: CollectionDataSource?
    var images = ImageClass.getImagesArray()
    var peekedData: ImageClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: collectionView)
        }
    }

}

//MARK:- VCFuncs
extension MainVC {
    func collectionViewConfigure() {
        let widthHeight = ScreenSize.WIDTH.cellHeightWidth(by: 2, noOfItems: 3, sideSpacing: 2)
        let collectionSIze = CollectionSize.init(CGSize.init(width: widthHeight, height: widthHeight), UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2), 2, 2)
        dataSource = CollectionDataSource.init(items: images, identifier: Identfier.ImageCell.rawValue, collectionSize: collectionSIze)
        
        dataSource?.configureCell = { (cell, indexPath, item) in
            (cell as? ImageCell)?.item = item as? ImageClass
        }
        
        dataSource?.didSelectItem = { (indexPath) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let destVC = storyboard.instantiateViewController(withIdentifier: "DetailVC")
            (destVC as? DetailVC)?.imgData = self.images[indexPath.item]
            self.present(destVC, animated: true, completion: nil)
        }
        
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
}

//MARK:- UIViewcontrollerPreview Delegate
extension MainVC: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let selectedIndexPath = collectionView.indexPathForItem(at: location)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let destVC = storyboard.instantiateViewController(withIdentifier: "PreviewVC")
        destVC.preferredContentSize = CGSize.init(width: ScreenSize.WIDTH.value, height: ScreenSize.WIDTH.value)
        peekedData = images[selectedIndexPath?.row ?? 0]
        (destVC as? PreviewVC)?.imgData = peekedData
        navigationController?.pushViewController(destVC, animated: true)
        return destVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let destVC = storyboard.instantiateViewController(withIdentifier: "DetailVC")
        (destVC as? DetailVC)?.imgData = peekedData
        show(destVC, sender: self)
    }
}
