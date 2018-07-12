//
//  CD_Group+CoreDataProperties.swift
//  seventyDays
//
//  Created by NAVER on 2017. 3. 20..
//  Copyright © 2017년 CISTREE. All rights reserved.
//

import Foundation
import CoreData


extension CD_Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_Group> {
        return NSFetchRequest<CD_Group>(entityName: "CD_Group");
    }


}
