//
//  String+Extensions.swift
//  weibotest
//
//  Created by mac on 2018/12/26.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

extension GGReactive where Base == String{
    /// 字符串Base64编码
    public var base64String: String?{
        return base.data(using: .utf8, allowLossyConversion: false)?.base64EncodedString()
    }
    /// Base64编码转字符串
    public var originalFromBase64: String?{
        guard let data = Data(base64Encoded: base) else {
            return ""
        }
        return String(data: data, encoding: .utf8 )
    }
    
    /**
     去掉首尾空格，包括制表符 \t  的字符串
     
     HT: HeadAndTail
     */
    public var stringNoHTSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return base.trimmingCharacters(in: whitespace)
    }
    /**
     去掉首尾空格 包括后面的换行 \n  的字符串
     
     HT: HeadAndTail
     */
    public var stringNoHTSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return base.trimmingCharacters(in: whitespace)
    }
    /**
    去掉所有空格 的字符串
     */
    public var stringNoSpace: String {
        return base.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /**
     去掉所有 空格、\n、\t 的字符串
    */
    public var stringNoSpacePro: String {
        let s1 = base.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        let s2 = s1.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
        return s2.replacingOccurrences(of: "\t", with: "", options: .literal, range: nil)
    }

    /// 去除首尾空白字符和 . 符号，以及去除中间所有空白字符的 字符串（主要用于创建 ApppVersion 对象）
    public var stringNoSpaceAndHTDot: String{
        return self.stringNoSpacePro.trimmingCharacters(in: CharacterSet(charactersIn: "."))
    }
    
    
    public var nsString: NSString {
        return (base as NSString)
    }
        
    public var lastPathComponent: String {
        return nsString.lastPathComponent
    }
    
    public var pathExtension: String {
        return nsString.pathExtension
    }
    
    public var deletingLastPathComponent: String {
        return nsString.deletingLastPathComponent
    }
    
    public var deletingPathExtension: String {
        return nsString.deletingPathExtension
    }
    
    public var pathComponents: [String] {
        return nsString.pathComponents
    }
    
    /**
     Returns a new string made by appending to the receiver a given string.
     
     
     The following table illustrates the effect of this method on a variety of different paths, assuming that aString is supplied as “scratch.tiff”:
     
            Receiver’s String Value  |  Resulting String
            ––––––––––––––––––––––––––––––––––––––––––––––––
              “/tmp”                 |  “/tmp/scratch.tiff”
              “/tmp/”                |  “/tmp/scratch.tiff”
              “/”                    |  “/scratch.tiff”
              “” (an empty string)   |  “scratch.tiff”
     
     Note that this method only works with file paths (not, for example, string representations of URLs).
    */
    public func appendingPathComponent(_ str: String) -> String {
        return nsString.appendingPathComponent(str)
    }
    
    /// 在路径后添加扩展名
    public func appendingPathExtension(_ str: String) -> String? {
        return nsString.appendingPathExtension(str)
    }
    
    /// 使用正则提取当前字符串的匹配项，并替换成目标字符串
    public func stringReplaceByRegex(pattern: String, regexOptions: NSRegularExpression.Options = [], matchingOptions: NSRegularExpression.MatchingOptions = [], withTemplate: String) -> String{

        let regex = try! NSRegularExpression(pattern: pattern, options: regexOptions)
        let newString = regex.stringByReplacingMatches(in: base, options: matchingOptions, range: NSMakeRange(0, base.count), withTemplate: withTemplate)
        
        return newString
    }
    
    
}
