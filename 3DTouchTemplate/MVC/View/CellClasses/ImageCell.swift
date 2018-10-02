//
//  ImageCell.swift
//  3DTouchTemplate
//
//  Created by Sandeep Kumar on 01/10/18.
//  Copyright © 2018 Sandeep Kumar. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    var item: ImageClass? {
        didSet {
            imgView.image = item?.image ?? UIImage()
        }
    }
}
