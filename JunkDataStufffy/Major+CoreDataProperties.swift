//
//  Major+CoreDataProperties.swift
//  JunkDataStufffy
//
//  Created by Justin Bengtson on 2/20/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//
//

import Foundation
import CoreData


extension Major {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Major> {
        return NSFetchRequest<Major>(entityName: "Major")
    }

    @NSManaged public var department: String?
    @NSManaged public var relationship: Student?

}
