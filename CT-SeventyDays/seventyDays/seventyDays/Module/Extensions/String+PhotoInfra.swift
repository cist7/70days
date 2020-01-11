//
//  String+PhotoInfra.swift
//  GP
//
//  http://wiki.navercorp.com/pages/viewpage.action?pageId=338622292
//
//  Created by Nakyung Lim on 2017. 6. 21..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import Foundation

extension String {
    
    /// 포토인프라 리사이징 파라미터가 뒤에 추가된 스트링을 생성한다.
    func resized(_ type: GPImageType) -> String {
        // mock data 사용 모드에서는 포토인프라 기능 미사용
//        guard GPMockDataManager.getMockDataSetting() == false else { return self }
        
        guard let parameter = type.parameter else { return self }
        
        return self + appendCharacter + parameter
    }
    
    // dthumb domain은 &, 일반 도메인은 ?를 붙인다.
    private var appendCharacter: String {
        guard let host = URL(string: self)?.host else { return "?" }
        
        return host.contains("dthumb.phinf.naver") ? "&" : "?"
    }
}

enum GPImageType {
    
    // 원본 비율
    case ratio1280
    case ratio1334
    
    // 9:16 타입. 옆 숫자는 point 기준 높이. 3x scale은 좀 더 큰 사이즈로 내려준다.
    case fixed200
    case fixed300
    
    // 정사각형 타입. 옆 숫자는 point 기준 최대 길이. 3x scale은 좀 더 큰 사이즈로 내려준다.
    case square40
    case square70
    case square120
    case square150
    case square210
    
    // 정사각형 타입. 옆 숫자는 point 기준 최대 길이. 2x/3x scale에 관계없이 동일한 사이즈를 내려준다.
    case squareAbs40
    case squareAbs70
    
    /// 포토인프라 리사이징 파라미터 스트링. ex) ?type=h1280
    fileprivate var parameter: String? {
        guard let type = photoInfraType else { return nil }
        
        return "type=" + type.rawValue
    }
    
    private var photoInfraType: PhotoInfraType? {
        let is3XScale = UIScreen.main.scale >= 3.0
        
        switch self {
        case .ratio1280: return is3XScale ? .h2208 : .h1280
        case .ratio1334: return is3XScale ? .h2208 : .h1334
            
        case .square40:   return is3XScale ? .f140_140 : .f72_72
        case .square70:  return is3XScale ? .f240_240 : .f140_140
        case .square120: return is3XScale ? .f300_300 : .f240_240
        case .square150: return is3XScale ? .f420_420 : .f300_300
        case .square210: return is3XScale ? .f560_560 : .f420_420
            
        case .squareAbs40: return .f72_72
        case .squareAbs70: return .f140_140
            
        case .fixed200:  return is3XScale ? .ff375_666 : .ff250_444
        case .fixed300:  return is3XScale ? .ff506_900 : .ff375_666
        }
    }
}

// 포토인프라 타입 파라미터
private enum PhotoInfraType: String {
    // 1:1 사이즈
    case f72_72, f140_140, f240_240, f560_560 // dthumb 미지원
    case f300_300, f420_420 // dthumb 지원
    
    // 9:16 사이즈
    case ff250_444, ff375_666, ff506_900 // 전부 dthumb 지원
    
    // 원본 비율 유지
    case h1280, h1334, h2208 // 전부 dthumb 지원
}
