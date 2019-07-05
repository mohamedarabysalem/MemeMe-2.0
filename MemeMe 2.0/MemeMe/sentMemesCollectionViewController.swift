//
//  sentMemesCollectionViewViewController.swift
//  MemeMe
//
//  Created by Mohamad Basuony on 3/3/19.
//  Copyright © 2019 Mohamad Basuony. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    var memes : [Meme]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    var chosenImage : UIImage?

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layOut = UICollectionViewFlowLayout()
        layOut.sectionInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 10, right: 0)
        layOut.itemSize = CGSize(width: itemSize, height: itemSize)
        layOut.minimumInteritemSpacing = 3
        layOut.minimumLineSpacing = 3
        collectionView.collectionViewLayout = layOut
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            self.collectionView.reloadData()
        }

        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meme", for: indexPath) as! CvMemeCell
        let meme = memes[indexPath.row]
        cell.setimg(image: meme.memedImg)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.chosenImage = memes[indexPath.row].memedImg
       
        performSegue(withIdentifier: "memeDetails", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memeDetails"{
            let vc = segue.destination as! MemeDetailsViewController
            vc.imagee = self.chosenImage
        }
    }

    @IBAction func addMeme(_ sender: Any) {
        performSegue(withIdentifier: "addMeme", sender: self)
    }
    

}
