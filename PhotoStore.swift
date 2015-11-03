//
//  PhotoStore.swift
//  PhotoManipulator
//
//  Created by Basement on 11/2/15.
//  Copyright © 2015 Mohanad. All rights reserved.
//

import Foundation
import CoreData
import UIKit
// A singleton class for storing addresses for pictures
class PhotoStore{
    // The singleton instance of the class, access by PhotoStore.sharedInstance
    static let sharedInstance: PhotoStore = PhotoStore()
    // The array that will hold the address of each picture
    var picArray: [PhotoModel] = []
    let managedObjectContext:NSManagedObjectContext
    let appDelegate: AppDelegate
    // The constructor must be private for it to be a singleton
    private init(){
//      Load the array from the database
        
//      The app delegate has a method already written for loading the managedobjectcontext
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//      The managed object context is what allows the data to be fetched and
//      allows querys to be performed on a model file
        managedObjectContext = appDelegate.managedObjectContext
//        The query is what will allow us to load the photo data, here we load the
//        photomodel table
        let query:NSFetchRequest = NSFetchRequest(entityName: "PhotoModel")
        do{
            picArray = try managedObjectContext.executeFetchRequest(query) as! [PhotoModel]
        }catch let error as NSError{
            print("An error ocurred:\(error.localizedDescription)")
        }
    }
    
    // Saves the picture addresses to the filesystem
    func saveContents(){
//        Instead of saving with the filemanager, now all we will have to do
//        is to save the managed object context model
//        Conveniently, the app delegate also already comes with a method for doing just that
        appDelegate.saveContext()
        
        
        /*
        let filemanager = NSFileManager.defaultManager()
        let path = imagePathForKey("pictures")
        filemanager.createFileAtPath(path, contents: NSKeyedArchiver.archivedDataWithRootObject(picArray), attributes: nil)*/
    }
    
    // This method will give you a path for the image to be placed in
    func imagePathForKey(key: String) -> String{
        
        let documentsDirectory: NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let path: String = documentsDirectory.stringByAppendingPathComponent(key);
        return path
    }
    
    // Adds picture to a PhotoModel object, and then save it to the managed object context
    func addPicture(picture: UIImage, name:String, caption:String="") -> String{
        let uuid = NSUUID()
        let filemanager = NSFileManager.defaultManager()
        let path = imagePathForKey(uuid.UUIDString)
        filemanager.createFileAtPath(path, contents: UIImageJPEGRepresentation(picture, 0.3), attributes: nil)
//        Here we will insert a new PhotoModel into the database and set some of its properties
            let photoModel = NSEntityDescription.insertNewObjectForEntityForName("PhotoModel", inManagedObjectContext: managedObjectContext) as! PhotoModel
            photoModel.photoLocation = uuid.UUIDString
            photoModel.name = name
            photoModel.caption = caption
            
            appDelegate.saveContext()
        picArray.append(photoModel)
        return uuid.UUIDString
    }
    
    // Returns a UIImage from a uuid key
    func getPicture(key: String) -> UIImage{
        let path = imagePathForKey(key)
        let filemanager = NSFileManager.defaultManager()
        let image: UIImage = UIImage(data: filemanager.contentsAtPath(path)!)!
        return image
    }
}
