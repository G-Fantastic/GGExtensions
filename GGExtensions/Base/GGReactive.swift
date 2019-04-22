//
//  GGReactive.swift
//  GGExtensions
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


/**
 使用`GGReactive`代理作为约束协议扩展的自定义点。一般模式是：
 扩展具有Base约束的GGReactive协议
 读作：当Base是SomeType（某种类型）时，扩展GGReactive
 
 ```
 extension GGReactive where Base: SomeType {
    // 在此处为SomeType添加任何特定的GGReactive扩展
 }
 ```
 通过这种方法（使用`Base`，而不仅仅是专用于普通的基本类型），我们可以使用更专用的方法和属性
 */
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



/// 为NSObject扩展`gg`代理。
extension NSObject: GGReactCompatible { }

