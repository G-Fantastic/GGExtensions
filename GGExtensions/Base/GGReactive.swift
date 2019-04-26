//
//  GGReactive.swift
//  GGExtensions
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


public struct GGReactive<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}


public protocol GGReactCompatible {
    associatedtype GGCompatibleType
    
    static var gg: GGReactive<GGCompatibleType>.Type { get set }
    
    var gg: GGReactive<GGCompatibleType> { get set }
}

extension GGReactCompatible {
    public static var gg: GGReactive<Self>.Type {
        get {
            return GGReactive<Self>.self
        }
        set {
        }
    }
    
    public var gg: GGReactive<Self> {
        get {
            return GGReactive(self)
        }
        set {
        }
    }
}




