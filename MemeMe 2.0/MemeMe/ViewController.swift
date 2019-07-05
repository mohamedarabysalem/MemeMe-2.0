//
//  ViewController.swift
//  MemeMe
//
//  Created by Mohamed Elaraby on 2/8/19.
//  Copyright © 2019 Mohamed Elaraby. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let imagePicker = UIImagePickerController()
    var memedImage : UIImage!
    var meme : Meme!
    let memeTextAttributes : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth : -3
        
    ]
    let vc = SentMemesViewController()

    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var shareButtonPressed: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomtextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        imagePicker.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tapToHideKeyboard()
        shareButtonPressed.isEnabled = false

        textFieldinit(textField: topTextField, text: "TOP")
        textFieldinit(textField: bottomtextField, text: "BOTTOM")
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        UIApplication.shared.statusBarStyle = .lightContent

        
    }
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    func textFieldinit (textField : UITextField ,text : String){
        textField.text = text
        textField.backgroundColor = UIColor.clear
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center

    }
    
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.imageView.image = selectedImage
        shareButtonPressed.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType){
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        present(imagePicker,animated: true,completion: nil)
    }
    @IBAction func albumButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            presentImagePickerWith(sourceType: .photoLibrary)
            
        }

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){

       presentImagePickerWith(sourceType: .camera)
        }
    }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if bottomtextField.isEditing{
            self.view.frame.origin.y = -getKeyboardHeight(notification: notification)
            
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    func generateMemedImage() -> UIImage {
        hideTopAndBottomBars(true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideTopAndBottomBars(false)
        
        return memedImage
    }
    func hideTopAndBottomBars(_ hide: Bool) {
        topToolBar.isHidden = hide
        bottomToolBar.isHidden = hide
    }
 
    func save(memedImg: UIImage){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomtextField.text!, img: imageView.image!, memedImg: memedImg)

        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    func share() {
        let memeToShare = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        activity.completionWithItemsHandler = { (activity, success, items, error) in
            
            if success {
                self.save(memedImg: memeToShare)
                self.dismiss(animated: true, completion: nil)

            }
        }
        present(activity, animated: true, completion:nil)
        

    }
    @IBAction func shareButtonPressed(_ sender: Any) {
        share()
    }
}
extension UIViewController {
    func tapToHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

