//
//  Student+CoreDataProperties.swift
//  JunkDataStufffy
//
//  Created by Justin Bengtson on 2/20/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var gpa: Float
    @NSManaged public var relationship: Major?

}
