//
//  GPNetworkService.swift
//  GP
//
//  Created by 이인재 on 2017.03.08.
//  Copyright © 2017 NAVER Corp. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON
//import CleanroomLogger

/// 서버 기본 API 대응
class GPNetworkResponse: Mappable {
    
    var status: String!                            // HTTP Status
    var success: Bool!                            // 성공 여부
    var errorMessage: String?                    // 에러 메시지
    var errorCode: String?                        // 에러 코드
    var errors: [GPNetworkResponseError]?        // 에러
    var generateError: NSError {
        return NSError(domain: GPNetworkResponseError.domain, code: errorCode?.int ?? 0, userInfo: ["message": errorMessage ?? ""])
    }
    
    required init?(map: Map) {
        guard map.JSON["success"] as? Bool != nil else { return nil }
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        success <- map["success"]
        errorMessage <- map["errorMessage"]
        errorCode <- map["errorCode"]
        errors <- map["errors"]
    }
}


/// 단일 모델용
class GPModelBase<T: Mappable>: GPNetworkResponse {
    
    var model: T?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        model <- map["result"]
    }
}

protocol GPListMappable: Mappable {
    
    /// GPListModelBase에서 hasPrevious, hasNext를 구하기 위해 필요.
    var uniqueField: String? { get }
}


/// Array 타입용. 타입으로 GPListMappable을 받는다. (hasNext, hasPrevious 사용을 위해 uniqueField가 필요함)
class GPListModelBase<T: GPListMappable>: GPNetworkResponse {

    var models: [T]?
    var previous: String?                // 이전 key
    var next: String?                    // 다음 key
    var totalCount: Int?                // 총 모델 개수
    var listCount: Int?                    // 목록의 아이템 수
    var scrollId: String?                // next와 같은 역할 하는 id (tag 검색 등에서 쓰임)
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        if map["result.list"].isKeyPresent {
            models <- map["result.list"]
        } else if map["result.data"].isKeyPresent {
            models <- map["result.data"]
        } else if map["result"].isKeyPresent, map.JSON["result"] is [Any] {
            models <- map["result"]
        }
        
        previous <- map["result.previous"]
        next <- map["result.next"]
        
        if map["result.totalCount"].isKeyPresent {
            totalCount <- map["result.totalCount"]
        } else if map["result.total"].isKeyPresent {
            totalCount <- map["result.total"]
        }
        
        listCount <- map["result.listCount"]
        scrollId <- map["result.scrollId"]
    }
}

extension GPListModelBase {
    
    /// 이전 데이터가 존재 여부
    var hasPrevious: Bool {
        guard let model = models?.first else { return false }
        guard let uniqueField = model.uniqueField else { return false }
        guard let previous = previous else { return false }
        
        if isExist(model: model, key: uniqueField, expectedValue: previous) {
            return false
        }
        
        return true
    }
    
    /// 다음 데이터 존재 여부
    var hasNext: Bool {
        guard let model = models?.last else { return false }
        guard let uniqueField = model.uniqueField else { return false }
        guard let next = next else { return false }
        
        if isExist(model: model, key: uniqueField, expectedValue: next) {
            return false
        }
        
        return true
    }
    
    private func isExist(model: T, key keyToLookup: String, expectedValue: String) -> Bool {
        var mirror: Mirror? = Mirror(reflecting: model)
        repeat {
            if let children = mirror?.children {
                for (key, value) in children {
                    if key == keyToLookup, let val = value as? String {
                        if val == expectedValue {
                            return true
                        }
                    }
                }
            }
            
            mirror = mirror?.superclassMirror
        } while mirror != nil
        
        return false
    }
}



class GPNetworkService {
	
	private init() {}
	
	/// 단일 모델 조회
	///
	/// - Parameters:
	///   - api: 사용할 API. GPUrlBuilder에서 처리하므로 실제 서비스 접근 부분만 필요. (ex)"sites/{siteId}/docs"
    ///   - apiType: 태그검색은 .tagSearch 명시. 미입력시 GP gateway로 동작한다.
	///   - method: HTTPMethod. 기본값은 get
	///   - parameters: 파라미터
	///   - encoding: 인코딩. JSONEncoding을 사용하면 파라미터가 http body에 삽입된다.
	///   - headers: 헤더
	///   - success: 성공 클로저
	///   - failure: 실패 클로저
	@discardableResult
	class func request<T: Mappable>(
		api: String,
		apiType: GPAPIGatewayType = .gp,
        method: HTTPMethod = .get,
		parameters: Parameters? = nil,
		encoding: ParameterEncoding = URLEncoding.default,
		headers: HTTPHeaders? = nil,
		success: ((GPModelBase<T>) -> Void)? = nil,
		failure: ((NSError?) -> Void)? = nil) -> DataRequest {
		
		let isJSONBody = encoding is JSONEncoding
		
		let url = GPUrlBuilder.createUrl(relativePath: api, apiType: apiType, parameters: isJSONBody ? nil : parameters)
        
        let request = Alamofire.request(url, method: method, parameters: isJSONBody ? parameters : nil, encoding: encoding, headers: headerWithUserAgent(currentHeader: headers))
        
//        request.responseData(completionHandler: )
        
//        request.response { (DefaultDataResponse) in
//
//        }
//
        request.responseObject { (response: DataResponse<GPModelBase<T>>) -> Void in
            if let result = response.result.value, response.error == nil {
                if response.result.isSuccess {
                    success?(result)
                } else {
                    let error = result.generateError
                    recordError(request: response.request, error: error)

                    failure?(error)
                }
            } else {
                recordError(request: response.request, error: response.error)
                
                failure?(response.error as NSError?)
            }
        }
		return request
    }
	
	/// 리스트 모델 조회. GPListMappable 타입 필요.
	///
	/// - Parameters:
	///   - api: 사용할 API. GPUrlBuilder에서 처리하므로 실제 서비스 접근 부분만 필요. (ex)"sites/{siteId}/docs"
    ///   - apiType: 태그검색은 .tagSearch 명시. 미입력시 GP gateway로 동작한다.
    ///   - method: HTTPMethod. 기본값은 get
	///   - parameters: 파라미터
	///   - encoding: 인코딩. JSONEncoding을 사용하면 파라미터가 http body에 삽입된다.
	///   - headers: 헤더
	///   - success: 성공 클로저
	///   - failure: 실패 클로저
	@discardableResult
	class func requestList<T: GPListMappable>(
		api: String,
		apiType: GPAPIGatewayType = .gp,
        method: HTTPMethod = .get,
		parameters: Parameters? = nil,
		encoding: ParameterEncoding = URLEncoding.default,
		headers: HTTPHeaders? = nil,
		success: ((GPListModelBase<T>) -> Void)? = nil,
		failure: ((NSError?) -> Void)? = nil) -> DataRequest {
		
		let isJSONBody = encoding is JSONEncoding
		
        let url = GPUrlBuilder.createUrl(relativePath: api, apiType: apiType, parameters: isJSONBody ? nil : parameters)
		
        let request = Alamofire.request(url, method: method, parameters: isJSONBody ? parameters : nil, encoding: encoding, headers: headerWithUserAgent(currentHeader: headers))
        
		request.responseObject { (response: DataResponse<GPListModelBase<T>>) -> Void in
			if let result = response.result.value, response.error == nil {
				if result.success {
					success?(result)
				} else {
                    let error = result.generateError
                    recordError(request: response.request, error: error)
                    
					failure?(error)
				}
			} else {
                recordError(request: response.request, error: response.error)
                
				failure?(response.error as NSError?)
			}
		}
		
		return request
    }
	
	/// JSON 조회.
	///
	/// - Parameters:
	///   - api: 사용할 API. GPUrlBuilder에서 처리하므로 실제 서비스 접근 부분만 필요. (ex)"sites/{siteId}/docs"
    ///   - needToCreateUrl: GPUrlBuilder로 url을 생성해야 하는지 여부. 명시적으로 false를 지정하는 경우에는 api paramter를 가공 없이 그대로 사용한다.
    ///   - apiType: 태그검색은 .tagSearch 명시. 미입력시 GP gateway로 동작한다.
    ///   - method: HTTPMethod. 기본값은 get
	///   - parameters: 파라미터
	///   - encoding: 인코딩. JSONEncoding을 사용하면 파라미터가 http body에 삽입된다.
	///   - headers: 헤더
    ///   - queue: closure가 실행될 queue.
	///   - success: 성공 클로저
	///   - failure: 실패 클로저
	@discardableResult
    class func requestJSON(
		api: String,
		apiType: GPAPIGatewayType = .gp,
		needToCreateUrl: Bool = true,
		method: HTTPMethod = .get,
		parameters: Parameters? = nil,
		encoding: ParameterEncoding = URLEncoding.default,
		headers: HTTPHeaders? = nil,
		queue: DispatchQueue? = nil,
		success: ((JSON) -> Void)? = nil,
		failure: ((NSError?) -> Void)? = nil) -> DataRequest {
		
		let isJSONBody = encoding is JSONEncoding
		
        let url = needToCreateUrl ? GPUrlBuilder.createUrl(relativePath: api, apiType: apiType, parameters: isJSONBody ? nil : parameters) : api
		
		let request = Alamofire.request(url, method: method, parameters: isJSONBody ? parameters : nil, encoding: encoding, headers: headerWithUserAgent(currentHeader: headers))
		request.responseJSON(queue: queue) { (response: DataResponse<Any>) -> Void in
			if let result = response.result.value, response.error == nil {
				let json = JSON(result)
				
				if json["success"].boolValue {
					success?(json)
				} else {
                    let error = NSError(domain: GPNetworkResponseError.domain, code: json["errorCode"].intValue, userInfo: ["message": json["errorMessage"].stringValue])
                    recordError(request: response.request, error: error)
                    
					failure?(error)
				}
			} else {
                recordError(request: response.request, error: response.error)
                
				failure?(response.error as NSError?)
			}
        }
		
		return request
    }
	
    /// multipart 업로드
    class func upload(multipartFormData: @escaping (MultipartFormData) -> Void,
                      usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
                      to url: URLConvertible,
                      method: HTTPMethod = .post,
                      headers: HTTPHeaders? = nil,
                      encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        Alamofire.upload(multipartFormData: multipartFormData,
                         usingThreshold: encodingMemoryThreshold,
                         to: url,
                         method: method,
                         headers: headerWithUserAgent(currentHeader: headers),
                         encodingCompletion: encodingCompletion)
    }
    
    // 헤더에 user agent 추가
    private class func headerWithUserAgent(currentHeader: HTTPHeaders?) -> HTTPHeaders {
        let userAgentField = "User-Agent"
        
        // 이미 헤더가 정의되어 있으면 그대로 사용.
        if let currentHeader = currentHeader, currentHeader[userAgentField] != nil {
            return currentHeader
        }
        
        var newHeader: HTTPHeaders = currentHeader ?? [:]
        newHeader[userAgentField] = String.createUserAgent()
        
        return newHeader
    }
    
    private class func recordError(request: URLRequest?, error: Any? = nil) {
        // GP 이외의 API (ex. SPLog) 는 result 구조가 달라서 에러로 분류될 수 있다. 이 경우에는 로그 남기지 않음.
        guard let url = request?.url?.absoluteString, url.contains("gpapp") == true else { return }
        
        var errorMessage: String?
        
        switch error {
        case is Error: errorMessage = (error as? Error)?.localizedDescription
        case is NSError: errorMessage = (error as? NSError)?.description
        default: break
        }
        
//        Log.warning?.message("\(url)\n\(errorMessage ?? "no error message found")", errorCode: "API")
    }
}


protocol GPErrorProtocol {
    
    static var domain: String { get }
}

enum GPError: Error, GPErrorProtocol {
    
    static let domain = Bundle.main.bundleIdentifier! + ".error"
}

/// 서버 API 공통 Error 모델
class GPNetworkResponseError: Mappable, GPErrorProtocol {
    
    static let domain = GPError.domain + ".error.server.response"

    var message: String = ""        // 에러 내용
    var reason: String = ""            // 에러 이유
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        reason <- map["reason"]
    }
}
