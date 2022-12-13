//
//  NSPredicate.swift
//  DGCoreData
//
//  Created by Xiao Jin on 2022/11/7.
//  Copyright © 2022 debugeek. All rights reserved.
//

import Foundation

extension NSPredicate {

    public class func from(_ condition: Any) -> NSPredicate? {
        if let predicate = condition as? NSPredicate {
            return predicate
        } else if let format = condition as? String {
            return NSPredicate(format: format)
        } else if let subpredicates = condition as? [String: String] {
            return NSCompoundPredicate(andPredicateWithSubpredicates: subpredicates.map { NSPredicate(format: "\($0) == '\($1)'") })
        } else {
            return nil
        }
    }

}
