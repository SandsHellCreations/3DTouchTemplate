//
//  PreviewVC.swift
//  3DTouchTemplate
//
//  Created by Sandeep Kumar on 02/10/18.
//  Copyright © 2018 Sandeep Kumar. All rights reserved.
//

import UIKit

class PreviewVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    var imgData: ImageClass?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = imgData?.image ?? UIImage()
    }

}
