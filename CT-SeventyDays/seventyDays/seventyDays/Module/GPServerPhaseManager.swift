//
//  GPServerPhaseManager.swift
//  GP
//
//  서버 Phase 변경을 관리하는 클래스. 싱글톤으로 사용
//
//  Created by Cho SeongHyun on 2017. 1. 17..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import Foundation

class GPServerPhaseManager {
    
    static let shared = GPServerPhaseManager()
    
    let kCurrentPhase = "kCurrentPhase"
    let defaultServerPhase: GPServerPhase = .dev
    
    func currentPhase() -> GPServerPhase {
        #if DEBUG || INHOUSE
            guard let phaseInt = UserDefaults.standard.value(forKey: kCurrentPhase) as? Int else { return defaultServerPhase }
            guard let phase = GPServerPhase(rawValue: phaseInt) else { return defaultServerPhase }
            
            return phase
        #else
            return .real
        #endif
    }
    
    func setCurrentPhase(phase: GPServerPhase) {
        #if DEBUG || INHOUSE
            UserDefaults.standard.set(phase.rawValue, forKey: kCurrentPhase)
        #else
            UserDefaults.standard.set(GPServerPhase.real.rawValue, forKey: kCurrentPhase)
        #endif
    }
    
    // 이전에 설정해 둔 서버값이 없으면 초기값 설정
    func initializeCurrentPhaseIfAvailable(to phase: GPServerPhase) {
        guard UserDefaults.standard.value(forKey: kCurrentPhase) == nil else { return }
        
        setCurrentPhase(phase: phase)
    }
}

// Int타입으로 사용하는 이유
//  1. UserDefault사용
//  2. UIAlertController의 ActionSheet에서 선택한 옵션과 enum을 쉽게 매칭하기 위함
enum GPServerPhase: Int {
    case dev
    case stage
    case real
    
    /// dev, stage, real 스트링 리턴
    var stringValue: String {
        return String(describing: self)
    }
    
    /// api 호출용 prefix 스트링에 .을 붙여서 리턴한다.
    var apiPrefix: String {
        switch self {
        case .dev:   return "dev."
        case .stage: return "stg."
        case .real:  return ""
        }
    }
}
