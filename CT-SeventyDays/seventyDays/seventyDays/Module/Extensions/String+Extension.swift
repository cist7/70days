//
//  String+Extension.swift
//  GP
//
//  Created by Nakyung Lim on 2017. 2. 23..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import Foundation
import SwifterSwift

// MARK:- 기타 Util성

extension String {
    
//    var stripHtmlTag: String {
//        guard let regEx = try? NSRegularExpression(pattern: "<(.|\n)*?>", options: []) else { return strimHtmlTagUsingAttributedString }
//
//        return regEx.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: count), withTemplate: "")
//    }
    
    // Attributed string 생성 방식으로 html tag 제거. 퍼포먼스가 떨어진다. regEx 실패시 방어용으로 사용.
//    private var strimHtmlTagUsingAttributedString: String {
//        guard let htmlStringData = data(using: .utf8),
////            let attributedHTMLString = try? NSAttributedString(data: htmlStringData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType as AnyObject, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue as AnyObject], documentAttributes: nil) else { return self }
//
//        return htmlStringData
//    }
    
    /// API relative path encoding
    var apiEncoded: String {
        let urlSet = CharacterSet.urlFragmentAllowed
            .union(.urlHostAllowed)
            .union(.urlPasswordAllowed)
            .union(.urlQueryAllowed)
            .union(.urlUserAllowed)
        
        return self.addingPercentEncoding(withAllowedCharacters: urlSet) ?? self
    }
    
    // API parameter encoding
    var apiParameterEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted) ?? self
    }
    
    /// http://가 붙어있지 않은 스트링이면 http:// 헤더를 붙인다. 이미 붙어있으면 return self
    var appendUrlHeaderIfNeed: String {
        return isValidUrlHeader ? self : "http://" + self
    }
    
    /// 스트링에 http:// 혹은 https:// 헤더가 붙어있는지 판단한다.
    var isValidUrlHeader: Bool {
        return hasPrefix("http://") || hasPrefix("https://")
    }
	
//	func nsRange(from range: Range<Index>) -> NSRange {
//		let lower = UTF16View.Index(range.lowerBound, within: utf16)
//		let upper = UTF16View.Index(range.upperBound, within: utf16)
//
//		return NSRange(location: utf16.startIndex.distance(to: lower), length: lower.distance(to: upper))
//	}
    
    /// white space를 %20 타입 스페이스로 변경한다.
    var adjustWhiteSpace: String {
        return components(separatedBy: .whitespaces).joined(separator: " ")
    }
}
