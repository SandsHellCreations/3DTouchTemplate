//
//  PreviewVC.swift
//  3DTouchTemplate
//
//  Created by Sandeep Kumar on 02/10/18.
//  Copyright © 2018 Sandeep Kumar. All rights reserved.
//

import UIKit

class PreviewVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK:- Variables
    var imgData: ImageClass?
    var initiatingVCRefrence: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = imgData?.image ?? UIImage()
    }
    
    
    override var previewActionItems: [UIPreviewActionItem] {
        return previewActions()
    }
    
    
    func previewActions() -> [UIPreviewActionItem] {
        guard let _ = initiatingVCRefrence as? MainVC else { return [] }
        let previewAction1 = UIPreviewAction.init(title: "Preview Action 1", style: .default) { (action, vcRefrence) in
            print("Tapped")
        }
        
        let previewAction2 = UIPreviewAction.init(title: "Preview Action 2", style: .default) { (action, vcRefrence) in
            print("Tapped")
        }
        return [previewAction1, previewAction2]
    }

}

