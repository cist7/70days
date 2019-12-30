//
//  GPProfileModel.swift
//  GP
//
//  로그인 유저의 프로필 정보.
//  Drawer, 프로필 편집에서 사용.
//
//  Created by Nakyung Lim on 2017. 5. 11..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

protocol GPProfileProtocol {
    var nickname: String! { get }
    var introduce: String? { get }
    var profileImageUrl: String? { get }
}

struct GPProfileModel: GPProfileProtocol {
	
	// GPListMappable
	var uniqueField: String? {
		return "nickname"
	}
	
	// GPCollectionViewModelProtocol
//	var presenter: GPCollectionViewPresenterProtocol?
	
    // 서버에 업로드할 url. full-path가 아닌 domain이 제거된 url이다.
    var profileImageUrl: String?
    
    // 로컬에서 Drawer 이미지 노출에 사용할 url. delivery domain이 추가된 full-path
    var profileImageUrlWithDomain: String?
    
    // UIImage instance는 프로필 편집시에만 사용. 평소 이미지 노출시에는 image url을 사용한다.
    var profileImageInstance: UIImage?
    
    var nickname: String!
	var siteId: String!
    
    /// 글 작성 권한이 있는 피플만 소개글이 존재한다.
    var introduce: String?
    
    /// 글 작성 권한이 있는 피플 여부
    var isContentCreator: Bool = false
	
	/// 현 유저가 팔로우 중인지 여부
	var isFollowedByAccessUser: Bool = false
	var followerCount: Int = 0
    
    init(profileImageUrlWithDomain: String?, profileImage: UIImage?, nickname: String, introduce: String?, isContentCreator: Bool) {
        self.profileImageUrlWithDomain = profileImageUrlWithDomain
        self.profileImageInstance = profileImage
        self.nickname = nickname
        self.introduce = introduce
        self.isContentCreator = isContentCreator
    }
    
    /// GPUserModel 기반으로 편집용 모델 생성
//    init(userModel: GPUserModel) {
//        self.init(profileImageUrlWithDomain: userModel.profileImageUrl, profileImage: nil, nickname: userModel.nickname, introduce: userModel.introduce, isContentCreator: userModel.isContentCreator)
//    }
    
    /// 가입 단계 추천 프로필 정보를 바탕으로 편집용 모델 생성
    init?(json: JSON) {
        guard let nickname = json["result"]["nickname"].string else { return nil }
        
        self.init(profileImageUrlWithDomain: json["result"]["profileImage"].string,
                  profileImage: nil,
                  nickname: nickname,
                  introduce: json["result"]["profileText"].string,
                  isContentCreator: false)
        
        // 추천 프로필 정보인 경우에는 도메인 URL을 서버로 그대로 업로드한다.
        self.profileImageUrl = self.profileImageUrlWithDomain
    }
	
	init() {}
	
	init?(map: Map) {
		guard map.JSON["nickname"] as? String != nil, map.JSON["siteId"] as? String != nil else { return nil }
	}
	
	mutating func mapping(map: Map) {
		siteId <- map["siteId"]
		nickname <- map["nickname"]
		profileImageUrl <- map["profileImage"]
		introduce <- map["introduce"]
		isFollowedByAccessUser <- map["isFollowing"]
		followerCount <- map["followerCount"]
	}
}

extension GPProfileModel: Equatable {
    
    static func == (lhs: GPProfileModel, rhs: GPProfileModel) -> Bool {
        return lhs.profileImageUrl == rhs.profileImageUrl
        && lhs.profileImageUrlWithDomain == rhs.profileImageUrlWithDomain
        && lhs.nickname == rhs.nickname
        && lhs.introduce == rhs.introduce
        && lhs.profileImageInstance == rhs.profileImageInstance
    }
}
