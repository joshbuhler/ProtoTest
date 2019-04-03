//
//  DataService.swift
//  ProtoTest
//
//  Created by Joshua Buhler on 4/2/19.
//  Copyright © 2019 JB. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataServiceProtocol {
    
    func addNotificationBlockForId<T: Object & Identifiable>(_ forId: Int, withNotificationBlock: @escaping(RealmCollectionChange<Results<T>>) -> Void) -> Int?
}

class DataService: DataServiceProtocol {
    func addNotificationBlockForId<T: Object & Identifiable>(_ forId: Int, withNotificationBlock: @escaping (RealmCollectionChange<Results<T>>) -> Void) -> Int? {
        
        print ("addNotificationBlockForId")
        
        return 3
    }
}
