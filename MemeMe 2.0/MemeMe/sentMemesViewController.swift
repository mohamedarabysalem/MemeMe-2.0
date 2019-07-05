//
//  sentMemesViewController.swift
//  MemeMe
//
//  Created by Mohamad Basuony on 3/1/19.
//  Copyright © 2019 Mohamad Basuony. All rights reserved.
//

import UIKit

class SentMemesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var chosenImage : UIImage?
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        update()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meme", for: indexPath) as! MemeCell
        let meme = memes[indexPath.row]
        let text = meme.topText + meme.bottomText
        cell.setData(img: meme.memedImg, text: text)
        print(meme.topText + meme.bottomText)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenImage = memes[indexPath.row].memedImg
        performSegue(withIdentifier: "memeDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memeDetails"{
            let vc = segue.destination as! MemeDetailsViewController
            vc.imagee = chosenImage
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addMeme", sender: self)
    }

    func update(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.tableView.reloadData()
            print(self.memes.count)
        }
    }
    
}
