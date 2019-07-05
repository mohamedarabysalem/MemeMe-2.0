//
//  TableViewCell.swift
//  MemeMe
//
//  Created by Mohamad Basuony on 3/1/19.
//  Copyright © 2019 Mohamad Basuony. All rights reserved.
//

import UIKit

class MemeCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    func setData(img : UIImage , text : String){
        imgView.image = img
        label.text = text
        
    }
    
}
