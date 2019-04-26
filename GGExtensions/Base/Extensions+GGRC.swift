//
//  Extensions+GGRC.swift
//  GGExtensions
//
//  Created by mac on 2019/4/3.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

// RC: ReactCompatible

/// 为 NSObject及其子类 扩展`gg`代理
extension NSObject: GGReactCompatible { }

/// 为 struct 类型扩展`gg`代理
extension String : GGReactCompatible{ }
extension Double : GGReactCompatible{ }
extension Int : GGReactCompatible{ }
extension Array : GGReactCompatible{ }
extension Dictionary : GGReactCompatible{ }
extension Date : GGReactCompatible{ }




