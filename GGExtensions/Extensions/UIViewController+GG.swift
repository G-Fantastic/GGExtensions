//
//  UIViewController+GG.swift
//  GGExtensions
//
//  Created by mac on 2019/4/23.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

extension GGReactive where Base : UIViewController{

    /// 获得当前VC的navigationBar的高度
    public var navBarHeight: CGFloat {
        return base.navigationController?.navigationBar.frame.height ?? 0
    }
    
    /// 获取当前VC的tabBar高度
    public var tabBarHeight: CGFloat{
        return base.tabBarController?.tabBar.bounds.height ?? 0
    }
    
}
