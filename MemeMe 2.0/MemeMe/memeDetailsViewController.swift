//
//  memeDetailsViewController.swift
//  MemeMe
//
//  Created by Mohamad Basuony on 3/1/19.
//  Copyright © 2019 Mohamad Basuony. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imagee : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        setimg()

        // Do any additional setup after loading the view.
    }
    func setimg(){
        imageView.image = imagee
    }
    

}
