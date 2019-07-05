//
//  File.swift
//  MemeMe
//
//  Created by Mohamad Basuony on 3/3/19.
//  Copyright © 2019 Mohamad Basuony. All rights reserved.
//

import Foundation
import UIKit

class CvMemeCell : UICollectionViewCell{
    
    @IBOutlet weak var img: UIImageView!
    func setimg (image : UIImage){
     img.image = image
    }
}
