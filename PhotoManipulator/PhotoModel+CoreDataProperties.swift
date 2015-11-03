//
//  PhotoModel+CoreDataProperties.swift
//  PhotoManipulator
//
//  Created by Basement on 11/2/15.
//  Copyright © 2015 Mohanad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PhotoModel {

    @NSManaged var photoLocation: String?
    @NSManaged var name: String?
    @NSManaged var caption: String?

}
