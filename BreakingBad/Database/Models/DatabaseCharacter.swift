//
//  DatabaseCharacter.swift
//  BreakingBad
//
//  Created by Phil Martin on 15/09/2022.
//

import CoreData

class DBCharacter: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var charId: Int64
    @NSManaged var img: String
}
