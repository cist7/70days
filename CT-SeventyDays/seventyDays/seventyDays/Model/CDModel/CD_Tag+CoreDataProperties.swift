//
//  CD_Tag+CoreDataProperties.swift
//  seventyDays
//
//  Created by NAVER on 2017. 3. 20..
//  Copyright © 2017년 CISTREE. All rights reserved.
//

import Foundation
import CoreData


extension CD_Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_Tag> {
        return NSFetchRequest<CD_Tag>(entityName: "CD_Tag");
    }

    @NSManaged public var tagCreated: NSDate?
    @NSManaged public var tagEdited: NSDate?
    @NSManaged public var tagDescription: String?
    @NSManaged public var tagName: String?
    @NSManaged public var tagImage: NSData?
    @NSManaged public var tagType: String?

}
