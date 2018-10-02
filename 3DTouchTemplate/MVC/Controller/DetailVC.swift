//
//  DetailVC.swift
//  3DTouchTemplate
//
//  Created by Sandeep Kumar on 02/10/18.
//  Copyright © 2018 Sandeep Kumar. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    //MARK:- Variables
    var imgData: ImageClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = imgData?.image ?? UIImage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
