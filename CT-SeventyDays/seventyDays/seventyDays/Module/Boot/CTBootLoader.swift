//
//  GPBootLoader.swift
//  GP
//
//  앱 실행시 1회성 initialization을 수행해야 하는 모듈들을 실행하는 클래스
//
//  Created by Nakyung Lim on 2017. 1. 10..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import Foundation
import UIKit

// 각 부트로더 모듈이 상속받을 프로토콜. instance를 생성하지 않고 class func으로 구현한다.
//protocol GPBootLoaderProtocol {
//    static func loadModule(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
//}
//
//class GPBootLoader {
//
//    private var didLaunchBootModules = false
//    static let shared = GPBootLoader()
//    private let syncBootLoaderModules: [GPBootLoaderProtocol.Type]
//    private let asyncBootLoaderModules: [GPBootLoaderProtocol.Type]
//
//    private init() {
//        // 부트로더 모듈 목록
//        syncBootLoaderModules = [
//            GPServerPhaseBootModule.self,
//            GPHMACBootModule.self,
//            GPLoginBootModule.self,
//            GPUserAgentBootModule.self
//        ]
//
//        // bg thread에서 실행할 부트로더 모듈 목록
//        asyncBootLoaderModules = [
//            GPMockDataSettingModule.self,
//            GPLoggerBootModule.self,
//            GPAppVersionRecordBootModule.self,
//            GPNeloBootModule.self,
//            GPAceBootModule.self,
//            GPDisplayAppInfoBootModule.self,
//            GPSoundCategoryBootModule.self
//        ]
//    }
//
//    // MARK:- Boot Loader
//
//    class func runBootLoaderModules(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
//        // 부트로더 모듈은 1회만 실행한다.
//        if shared.didLaunchBootModules == true { return }
//
//        shared.runBootLoaderModulesOnInstance(application: application, launchOptions: launchOptions)
//    }
//
//    private func runBootLoaderModulesOnInstance(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
//        didLaunchBootModules = true
//
//        syncBootLoaderModules.forEach { module in
//            module.loadModule(application: application, launchOptions: launchOptions)
//        }
//
//        DispatchQueue.global().async { [weak self] in
//            self?.asyncBootLoaderModules.forEach { module in
//                module.loadModule(application: application, launchOptions: launchOptions)
//            }
//        }
//    }
//}
