//
//  Identifiable.swift
//  ProtoTest
//
//  Created by Joshua Buhler on 4/2/19.
//  Copyright © 2019 Joshua Buhler. All rights reserved.
//

import Foundation
import RealmSwift

public typealias IdentifiableObject = (Object & Identifiable)

public protocol Identifiable : class {
    var id: Int { get }
    var name: String { get }
}

extension Identifiable where Self: Object {
    
}
