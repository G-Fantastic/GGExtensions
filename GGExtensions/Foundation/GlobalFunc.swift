//
//  GlobalFunc.swift
//  GGExtensions
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

/**
 获取对象的类名
 
 由于 NSStringFromClass 接收的是 AnyClass，而 typealias AnyClass = AnyObject.Type，所以，type(of: ) 应该接收一个 AnyObject 的值。当然，如果当独把 type(of: ) 拿出来讨论，它是可以接收任意值，如：Any，而不仅仅局限于 AnyObject。
 */
internal func ClassName(of value: AnyObject) -> String {
    let subName = NSStringFromClass(type(of: value))
    return subName
}

/**
 * 通过字符串获取对应的类
 */
internal func ClassFromString<T>(_ className: String, _ classType: T.Type) -> T.Type? {
    return NSClassFromString(className) as? T.Type
}


