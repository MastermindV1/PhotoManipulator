//
//  CreatePhotoViewController.swift
//  PhotoManipulator
//
//  Created by Basement on 11/2/15.
//  Copyright © 2015 Mohanad. All rights reserved.
//

import UIKit

class CreatePhotoViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func backgroundTouched(sender: AnyObject) {
//        This method is here to make sure the keyboard goes away when the user taps on the white background
        nameTextField.resignFirstResponder()
        captionTextField.resignFirstResponder()
    }
    override func viewDidLoad() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Camera, target: self, action: "takePicture"), UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Done, target: self, action: "finish")]

    }
    
    func takePicture(){
        let picker:UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        var sourceType:UIImagePickerControllerSourceType
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            sourceType = .Camera
        }else{
            sourceType = .PhotoLibrary
        }
        
        picker.sourceType = sourceType
//        self.navigationController!.presentViewController(picker, animated: true, completion: nil)
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: {
            // Add the picture to the store
            if(info.count > 0){
                let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                self.imageView.image = image
            }
        })
    }
    
    func finish(){
        PhotoStore.sharedInstance.addPicture(imageView.image!, name: self.nameTextField.text!, caption: self.captionTextField.text!)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
