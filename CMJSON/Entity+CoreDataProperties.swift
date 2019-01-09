//
//  Entity+CoreDataProperties.swift
//  CMJSON
//
//  Created by Bilal Yousaf on 04/01/2018.
//  Copyright © 2018 Bilal Yousaf. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity");
    }

    @NSManaged public var item: String?

}
