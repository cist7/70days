//
//  GPUrlBuilder.swift
//  GP
//
//  Created by Nakyung Lim on 2017. 2. 16..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import Foundation
//import ApiGatewayHMAC

/// API Gateway 타입
///
/// 현재는 GP API만 사용하지만 혹시 추후 tong이나 기타 다른 API를 사용할 경우를 대비해 기본 구조를 제거하지 않고 그대로 남겨둔다.
enum GPAPIGatewayType: String {
    case gp = "gpugc"
    
    var serviceName: String {
        switch self {
        case .gp: return GPServerPhaseManager.shared.currentPhase() == .dev ? "gpugc" : "selective"
        }
    }
}

class GPUrlBuilder {
    
    /// 현재 server phase 설정값에 기반한 API 주소를 생성하고 HMAC encryption을 한다.
    ///
    /// - Parameters:
    ///   - version: API version. 미입력시 기본값 1로 동작한다.
    ///   - relativePath: url string. 스트링 앞에 /가 있던 없던간에 관계없이 동작한다.
    ///   - apiType: 태그검색은 .tagSearch 명시. 미입력시 GP gateway로 동작한다.
    ///   - parameters: paramter dictionary
    /// - Returns: 생성된 url String
    class func createUrl(version: Int = 1, relativePath: String, apiType: GPAPIGatewayType = .gp, parameters: [String: Any]? = nil) -> String {
        var url = apiPath(apiType: apiType) + "v" + String(version) + "/" + validate(relativePath: relativePath).apiEncoded
        
        if let param = parameters {
            let queryString = queryStrig(with: param)
            url = url.appending(queryString)
        }
        
//        url = NMacManager.encryptUrl(url)
        
        return url
    }
    
    /// next key parameter 생성
    class func createParameter(nextKey: String?) -> [String: Any] {
        var parameters: [String: Any] = ["count": 20]
        
        if let nextKey = nextKey {
            parameters["next"] = nextKey
        }
        
        return parameters
    }
}

extension GPUrlBuilder {
    
    fileprivate class func apiPath(apiType: GPAPIGatewayType) -> String {
        return "http://\(GPServerPhaseManager.shared.currentPhase().apiPrefix)apis.naver.com/" + apiPartner + "/" + apiType.serviceName + "/"
    }
    
    fileprivate static var apiPartner: String {
        switch GPServerPhaseManager.shared.currentPhase() {
        case .dev: return "gpapp"
        case .stage, .real: return "selectiveApp"
        }
    }
    
    // 주소 앞에 /가 붙어있으면 제거한다.
    fileprivate class func validate(relativePath: String) -> String {
        if relativePath.firstCharacter == "/" {
            var characters = relativePath
            characters.removeFirst()
            
            return String(characters)
        } else {
            return relativePath
        }
    }
    
    /// API에 URL Query 파라미터를 사용할 때, Dictionary를 Query로 파싱하는 메소드
    fileprivate class func queryStrig(with param: [String: Any], startsWithQuestionMark: Bool = true) -> String {
        var query = ""
        
        for key in param.keys {
            guard let value = param[key] else { continue }
            
            if query.count == 0 {
                query = startsWithQuestionMark ? "?" : ""
            } else {
                query = query.appending("&")
            }
            
            query = query.appending("\(key)=\((value as? String)?.apiParameterEncoded ?? value)").replacing("\n", with: "%0A")
        }
        
        return query
    }
}

extension String {
    /// SwifterSwift: First character of string (if applicable).
    public var firstCharacter: String? {
        guard let first = self.first else {
            return nil
        }
        return String(first)
    }
    
    /// SwifterSwift: String by replacing part of string with another string.
    ///
    /// - Parameters:
    ///   - substring: old substring to find and replace.
    ///   - newString: new string to insert in old string place.
    /// - Returns: string after replacing substring with newString.
    public func replacing(_ substring: String, with newString: String) -> String {
        return replacingOccurrences(of: substring, with: newString)
    }
}
