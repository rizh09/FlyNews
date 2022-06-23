//
//  CustomContentCell.swift
//  Tabbed app
//
//  Created by NHT Global on 22/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import UIKit


protocol CustomCellDelegate : class{
    func didCopy(_ gifUrl:String)
}

class CustomContentCell:UITableViewCell{
    
    var cellDelegate : CustomCellDelegate?
    var gifUrl : String?
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var btnCopyOutlet: UIButton!
    @IBAction func didCopy(_ sender: Any) {
         cellDelegate?.didCopy(gifUrl!)

    }
    
    func hideCopyBtn(){
        btnCopyOutlet.isHidden = true
    }
}
