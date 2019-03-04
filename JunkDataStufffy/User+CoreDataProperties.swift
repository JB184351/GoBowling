//
//  User+CoreDataProperties.swift
//  JunkDataStufffy
//
//  Created by Justin Bengtson on 2/20/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var password: String?
    @NSManaged public var age: Int16
    @NSManaged public var name: String?

}
