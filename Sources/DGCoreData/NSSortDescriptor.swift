//
//  NSSortDescriptor.swift
//  DGCoreData
//
//  Created by Xiao Jin on 2022/11/7.
//  Copyright © 2022 debugeek. All rights reserved.
//

import Foundation

extension NSSortDescriptor {

    public class func from(_ order: Any) -> [NSSortDescriptor]? {
        if let sortDescriptor = order as? NSSortDescriptor {
            return [sortDescriptor]
        } else if let key = order as? String {
            return [NSSortDescriptor(key: key, ascending: true)]
        } else if let descriptors = order as? [String: String] {
            var sortDescriptors: [NSSortDescriptor] = []
            for (key, value) in descriptors {
                sortDescriptors.append(NSSortDescriptor(key: key, ascending: value.lowercased() != "desc"))
            }
            return sortDescriptors
        }
        return nil
    }

}
