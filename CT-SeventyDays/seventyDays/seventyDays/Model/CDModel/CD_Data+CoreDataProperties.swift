//
//  CD_Data+CoreDataProperties.swift
//  seventyDays
//
//  Created by NAVER on 2017. 3. 20..
//  Copyright © 2017년 CISTREE. All rights reserved.
//

import Foundation
import CoreData


extension CD_Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_Data> {
        return NSFetchRequest<CD_Data>(entityName: "CD_Data");
    }

    @NSManaged public var dataImage: NSData?
    @NSManaged public var dataType: String?
    @NSManaged public var dataName: String?
    @NSManaged public var dataBinary: NSData?
    @NSManaged public var dataEdited: NSDate?
    @NSManaged public var dataCreated: NSDate?
    @NSManaged public var dataDescription: String?

}
