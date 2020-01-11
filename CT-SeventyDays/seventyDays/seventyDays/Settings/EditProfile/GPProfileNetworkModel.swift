////
////  GPProfileNetworkModel.swift
////  GP
////
////  미가입 사용자 추천 프로필 조회
////  http://dev.api.gp.naver.com/swagger-ui.html#!/user-api-controller/recommendProfileUsingGET
////
////  Created by Nakyung Lim on 2017. 6. 12..
////  Copyright © 2017년 NAVER Corp. All rights reserved.
////
//
import Foundation
import Alamofire
//import CleanroomLogger
import SwiftyJSON

class GPProfileNetworkModel {
    
    /// 미가입 사용자의 추천 프로필 조회
    class func fetchRecommendProfile(success: @escaping ((GPProfileModel) -> Void), failure: ((NSError?) -> Void)?) {
        GPNetworkService.requestJSON(api: "users/profile/recommendation", success: { json in
            if let model = GPProfileModel(json: json) {
                success(model)
            } else {
                failure?(nil)
            }
        }, failure: { error in
            failure?(error)
        })
    }
    
    /// 프로필 업데이트
    class func updateProfile(model: GPProfileModel, success: @escaping (() -> Void), failure: ((NicknameError?) -> Void)?, finally: (() -> Void)?) {
        let parameter = createUpdateParameter(model: model)
        
        GPNetworkService.requestJSON(api: "users/@Self", method: .patch, parameters: parameter, encoding: JSONEncoding.default, success: { (json) in
            if json["success"].bool == true {
                success()
            } else {
                failure?(NicknameError(error: nil))
            }
            
            finally?()
        }, failure: { error in
            failure?(NicknameError(error: error))
            finally?()
        })
    }
    
    private class func createUpdateParameter(model: GPProfileModel) -> [String: String] {
        var parameter = [String: String]()
        
        if let nickname = model.nickname { parameter["nickname"] = nickname }
        if let profileText = model.introduce { parameter["profileText"] = profileText }
        
        if let profileImage = model.profileImageUrl {
            // 이미지가 변경되었으면 domain이 붙어있지 않은 이미지 URL 전송
            parameter["profileImage"] = profileImage
        } else if model.profileImageUrlWithDomain == nil {
            // domain이 포함된 이미지 URL이 nil이면 사용자가 이미지를 삭제한 상황.
            parameter["profileImage"] = ""
        }
        
        return parameter
    }
    
    /// 닉네임 유효성 체크
    class func checkValidNickname(nickname: String, success: @escaping ((String, NicknameError?) -> Void), failure: ((NSError?) -> Void)?, finally: (() -> Void)?) {
        
        //https://s3.ap-northeast-2.amazonaws.com/profileimage.cistree.net/pirate.png
        
        GPNetworkService.requestJSON(api: "users/nickname/\(nickname.apiParameterEncoded)/valid", success: { (json) in
            // 유효성 체크에 사용한 닉네임 스트링과 유효성 state값을 success closure에 전달.
            success(nickname, nil)
//            success(nickname, NicknameError(error: json["result"]))
            finally?()
        }, failure: { error in
            failure?(error)
            finally?()
        })
    }
    
    private class func createValidNicknameParameter(nickname: String?) -> [String: String] {
        var parameter = [String: String]()
        
        if let nickname = nickname { parameter["nickname"] = nickname }
        return parameter
    }
}

