//
//  UIView+Subviews.swift
//  weibotest
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit

#else
import AppKit
#endif

/// 对UIView的Subviews的操作的Extensions
extension GGReactive where Base : UIView{
    
    /**
     当前uiview所有subviews的字典形式
     
     注意：有些subview可能是在界面布局完成之后才真正添加上去的，所有此方法最好在"界面加载结束"的"完成回调"中执行，或者直接延迟执行1~2s
     */
    public var subviewsDict: [UIView : Any]{
        return subviewsToDict()
    }
    
    
    /**
     当前uiview所有subviews的字典形式，以“view的类名”作为KEY
     
     注意：有些subview可能是在界面布局完成之后才真正添加上去的，所有此方法最好在"界面加载结束"的"完成回调"中执行，或者直接延迟执行1~2s
     */
    public var subviewsStringDict: [String : Any]{
        return subviewsToStringDict()
    }
    
    /**
     当前uiview所有subviews的完整层级关系的字符串数组
     
     注意：有些subview可能是在界面布局完成之后才真正添加上去的，所有此方法最好在"界面加载结束"的"完成回调"中执行，或者直接延迟执行1~2s
    */
    public var subviewsPaths: [String]{
        return getSubviewsPaths()
    }
    
    
    /**
     递归打印当前UIView的所有子View
     
     注意：有些subview可能是在界面布局完成之后才真正添加上去的，所有此方法最好在"界面加载结束"的"完成回调"中执行，或者直接延迟执行1~2s
     */
    public func printSubviews(_ prefix: String = "", _ pre: String = "") {
        print(prefix + pre + ClassName(of: base))
        for subview in base.subviews{
            subview.gg.printSubviews("\t\(prefix)", "|- ")
        }
    }
    
    /**
     递归打印当前UIView的subviewsDict
     
     注意：有些subview可能是在界面布局完成之后才真正添加上去的，所有此方法最好在"界面加载结束"的"完成回调"中执行，或者直接延迟执行1~2s
     */
    public func printSubviewsDict(_ prefix: String = "", _ pre: String = "", _ dict: [UIView : Any]? = nil) {
        // 方法一：效率低
        //        print(prefix + pre + ClassName(of: self))
        //
        //        let valueDict = subviewsDict[self] as? [UIView : Any]
        //
        //        guard let unpackDict = valueDict else {
        //            return
        //        }
        //        for key in unpackDict.keys{
        //            key.printSubviewsDict("\t\(prefix)", "|- ")
        //        }
        
        // 方法二：不用重复计算subviewsDict（因为subviewsDict是计算型属性，每次调用都会重新计算）。这种方式效率高
        
        // 成员变量 subviewsDict 不能直接作为参数的默认值，只要 dict 不为 nil，subviewsDict就不会被执行
        let unpackSubviewsDict = dict ?? subviewsDict
        
        for key in unpackSubviewsDict.keys{
            print(prefix + pre + ClassName(of: key))
            
            let valueDict = unpackSubviewsDict[key] as? [UIView : Any]
            guard let unpackDict = valueDict else {
                continue
            }
            self.printSubviewsDict("\t\(prefix)", "|- ", unpackDict)
        }
    }
    
    
    /**
     递归打印当前UIView的 subviewsStringDict
     
     注意：有些subview可能是在界面布局完成之后才真正添加上去的，所有此方法最好在"界面加载结束"的"完成回调"中执行，或者直接延迟执行1~2s
     */
    public func printSubviewsStringDict(_ prefix: String = "", _ pre: String = "", _ dict: [String : Any]? = nil) {
        let unpackSubviewsStringDict = dict ?? subviewsStringDict
        
        for key in unpackSubviewsStringDict.keys{
            print(prefix + pre + key)
            
            let valueDict = unpackSubviewsStringDict[key] as? [String : Any]
            guard let unpackDict = valueDict else {
                continue
            }
            self.printSubviewsStringDict("\t\(prefix)", "|- ", unpackDict)
        }
    }
    
    /**
     打印当前UIView的 subviewsPaths
     
     注意：有些subview可能是在界面布局完成之后才真正添加上去的，所有此方法最好在"界面加载结束"的"完成回调"中执行，或者直接延迟执行1~2s
     */
    public func printSubviewsPaths() {
        subviewsPaths.forEach{e in print(e)}
    }
    
    
    /**
     将当前view的subviews全部存入字典中
     
     返回值应该使用 [UIView : Any] 而不是 [String : Any]，因为 UIView 的类名可能会重复，那么字典中只能存储一个，直接存储UIView对象，就不会重复
     */
    fileprivate func subviewsToDict() -> [UIView : Any] {
        var viewDict: [UIView : Any] = [:]
        //        let selfStr = ClassName(of: self)
        for subview in base.subviews{
            //            let subviewStr = ClassName(of: subview)
            let value = viewDict[base]
            
            if let value = value{
                // value一定是[UIView : Any]，因为存储的时候，都是存字典
                var valueDict = value as! [UIView : Any]
                valueDict.merge(subview.gg.subviewsToDict()) { (current, _) in current }
                viewDict[base] = valueDict
                
            }else{
                if subview.subviews.count == 0{
                    viewDict[base] = [subview : ""]
                    continue
                }else{
                    viewDict[base] = subview.gg.subviewsToDict()
                }
            }
        }
        
        if viewDict.count != 0{
            return viewDict
        }else{
            return [base : ""]
        }
        
    }
    
    /**
     将当前view的subviews全部存入字典中，以“view的类名”作为KEY
     
     返回值使用 [String : Any]，若view的类名有重复，使用 "-序号"  序号从0开始计数
     */
    fileprivate func subviewsToStringDict() -> [String : Any] {
        var viewDict: [String : Any] = [:]
        let selfStr = ClassName(of: base)
        for subview in base.subviews{
            let subviewStr = ClassName(of: subview)
            let value = viewDict[selfStr]
            
            if let value = value{
                // value一定是[String : Any]，因为存储的时候，都是存字典
                var valueDict = value as! [String : Any]
                let tempDict = subview.gg.subviewsToStringDict()
                
                var dupCount = 0
                for key in valueDict.keys{
                    if key == subviewStr{  // 如果有重复的key，那么直接跳出循环
                        dupCount = 1;
                        break
                    }
                    
                    if key.hasPrefix(subviewStr+"-"){
                        dupCount += 1
                    }
                }
                
                switch dupCount{
                case 0: // 没有重复的key
                    valueDict.merge(tempDict) { current, _ in current }
                case 1: // 只有一个重复的key，并且是相等的
                    let tempValue = valueDict[subviewStr]
                    valueDict.removeValue(forKey: subviewStr)
                    valueDict[subviewStr+"-0"] = tempValue
                    
                    let tempValue1 = tempDict[subviewStr]
                    valueDict[subviewStr+"-1"] = tempValue1
                    
                default:
                    valueDict[subviewStr+"-\(dupCount+1)"] = tempDict[subviewStr]
                }
                
                viewDict[selfStr] = valueDict
                
            }else{
                if subview.subviews.count == 0{
                    viewDict[selfStr] = [subviewStr : ""]
                    continue
                }else{
                    viewDict[selfStr] = subview.gg.subviewsToStringDict()
                }
            }
        }
        
        if viewDict.count != 0{
            return viewDict
        }else{
            return [selfStr : ""]
        }
        
    }
    
    
    
    /**
     获取当前uiview所有subviews的完整层级关系的字符串数组
    */
    fileprivate func getSubviewsPaths(prePath: String = "") -> [String] {
        var subviewsPathArr: [String] = []
        let selfStr = ClassName(of: base)
        
        if base.subviews.count == 0 {
            subviewsPathArr.append(prePath + selfStr)
        }else{
            for subview in base.subviews{
                subviewsPathArr.append(contentsOf: subview.gg.getSubviewsPaths(prePath: prePath+selfStr+" ➙ "))
            }
        }
        return subviewsPathArr
    }
    
    
    /**
     从指定的UIView中，查找指定路径（父子层级关系）的subviews
     
     注意：有些subview可能是在界面布局完成之后才真正添加上去的，所有此方法最好在"界面加载结束"的"完成回调"中执行，或者直接延迟执行1~2s
     - Parameter path: path的元素可以是跳跃的，如：
        原路径是：uiview1 -> uiview2 -> uiview3 -> uiview4，path = [uiview1, uiview4]，那么也是能够匹配此路径的
     */
    public func findSubview(_ path: [String]) -> (matchPaths: [String], foundIndexs: [[Int]]) {  // 元组的标签可以写在返回值的类型上
        var matchPaths: [String] = []
        var foundIndexs: [[Int]] = []
        
        for subviewsPath in subviewsPaths {
            // 数组初始化为 -1，isFinds中的[1, path.count+1]元素对应从subviewsPath找到的目标位置
            var isFinds = [Int](repeatElement(-1, count: path.count + 1))
            
            let pathNodes = subviewsPath.components(separatedBy: " ➙ ")
            
            for i in 0..<path.count{
                // isFinds[i] 是前一个元素找到的位置，所以新的元素应该从 +1 位置开始搜索
                for j in isFinds[i] + 1..<pathNodes.count{
                    if path[i] == pathNodes[j]{
                        isFinds[i+1] = j  // 将此序号记录在 isFinds 中
                        break
                    }
                }
            }
            
            // print(isFinds)
            
            var isMatch = true
            for i in 1..<isFinds.count{
                if isFinds[i] == -1{   // isFinds  1..<isFinds.count 任意一个元素等于 -1，都说明不匹配
                    isMatch = false
                    break
                }
            }
            
            if isMatch{
                matchPaths.append(subviewsPath)
                isFinds.remove(at: 0)
                foundIndexs.append(isFinds)
            }
            
        }
        
        
        return (matchPaths, foundIndexs)
    }
    
}

