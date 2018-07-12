//
//  CD_Memory+CoreDataProperties.swift
//  seventyDays
//
//  Created by NAVER on 2017. 3. 20..
//  Copyright © 2017년 CISTREE. All rights reserved.
//

import Foundation
import CoreData


extension CD_Memory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_Memory> {
        return NSFetchRequest<CD_Memory>(entityName: "CD_Memory");
    }

    @NSManaged public var memoryCreated: NSDate?
    @NSManaged public var memoryEdited: NSDate?
    @NSManaged public var memoryDescription: String?
    @NSManaged public var memoryName: String?
    @NSManaged public var memoryImage: NSData?
    @NSManaged public var memoryType: String?

}
