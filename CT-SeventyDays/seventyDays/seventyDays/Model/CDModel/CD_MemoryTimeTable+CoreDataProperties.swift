//
//  CD_MemoryTimeTable+CoreDataProperties.swift
//  seventyDays
//
//  Created by NAVER on 2017. 3. 20..
//  Copyright © 2017년 CISTREE. All rights reserved.
//

import Foundation
import CoreData


extension CD_MemoryTimeTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_MemoryTimeTable> {
        return NSFetchRequest<CD_MemoryTimeTable>(entityName: "CD_MemoryTimeTable");
    }


}
