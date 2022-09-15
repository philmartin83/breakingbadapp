//
//  NSManagedObject+Extension.swift
//  BreakingBad
//
//  Created by Phil Martin on 15/09/2022.
//

import Foundation
import CoreData

extension NSManagedObject
{

    class func entityName() -> String {
        let classString = NSStringFromClass(self)

        return classString.components(separatedBy: ".").last ?? classString
    }
}
