//
//  GPEditProfileViewController+Networking.swift
//  GP
//
//  Created by Nakyung Lim on 2017. 6. 12..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import UIKit
//import EZAlertController
//import CleanroomLogger

// MARK:- 프로필 정보 조회

extension GPEditProfileViewController {
    
    func initializeModel() {
        // 호출하는 쪽에서 원본 모델을 할당했으면 별도의 액션 불필요.
        guard profileModelOrigin == nil else { return }
        
        // 이미 가입한 사용자의 프로필 편집 모드이면 1차로 Configuration manager에서 모델 획득 시도
//        if isEditProfileType == true, let userModel = GPConfigurationManager.shared.userModel {
//            profileModelOrigin = GPProfileModel(userModel: userModel)
//            return
//        }
        
        // 원본 모델이 없으면 API 조회
        fetchProfileInfo(success: { [weak self] (model) in
            self?.profileModelOrigin = model
            
//            guard self?.isViewLoaded == true else { return }
            
            self?.initializeSubviews()
            }, failure: { [weak self] _ in
//                EZAlertController.errorAlert(from: self, acceptBlock: { [weak self] in
//                    self?.navigationController?.popViewController(animated: true)
//                })
        })
    }
    
    // 최초 가입 단계인지, 아니면 이미 가입된 사용자의 프로필 수정인지 판단해서 해당되는 API 호출
    private func fetchProfileInfo(success: @escaping ((GPProfileModel) -> Void), failure: ((NSError?) -> Void)?) {
        if isEditProfileType == true {
            fetchMyProfileInfo(success: success, failure: failure)
        } else {
            fetchInitialProfileInfo(success: success, failure: failure)
        }
    }
    
    // 이미 가입되어 있는 사용자의 프로필 정보 조회
    private func fetchMyProfileInfo(success: @escaping ((GPProfileModel) -> Void), failure: ((NSError?) -> Void)?) {
//        guard let siteId = GPLoginManager.shared.siteId else {
//            failure?(nil)
//            return
//        }
//
//		GPMyNetworkModel.userDetailInfo(referenceInfo: GPMyReferenceInfo(id: siteId, type: .siteId), success: { userModel in
//            success(GPProfileModel(userModel: userModel))
//        }, failure: { error in
//            failure?(error)
//        })
    }
    
    // 최초 가입 단계의 추천 닉네임 조회
    private func fetchInitialProfileInfo(success: @escaping ((GPProfileModel) -> Void), failure: ((NSError?) -> Void)?) {
//        GPProfileNetworkModel.fetchRecommendProfile(success: success, failure: failure)
    }
}

// MARK:- 닉네임 validation

extension GPEditProfileViewController {
    
    func checkNicknameValidation(success: @escaping ((String, GPNicknameValidationState) -> Void), failure: ((NSError?) -> Void)?) {
        guard let text = nickNameTextField.text, text.count > 0 else {
            success("", .empty)
            return
        }
        
        // nickname validation을 진행하는 동안은 상태를 unknown으로 변경한다.
        nicknameState = .unknown
        
//        GPProfileNetworkModel.checkValidNickname(nickname: text, success: { text, nicknameError in
//            success(text, GPNicknameValidationState(nicknameError: nicknameError))
//        }, failure: failure, finally: nil)
    }
}

// MARK:- 변경사항 업로드

enum NicknameError: Error {
    
    // 'VALID', 'VALID_IN_USE', 'INVALID_LENGTH', 'INVALID_CHARACTER', 'INVALID_DUPLICATED', INVALID_PWM_FILTERED
    case invalid
    case occupied
    case unknown
    
//    init?(json: JSON?) {
//        // 사용 가능
//        guard json?["valid"].bool != true else { return nil }
//        
//        // 에러타입 없음
//        guard let message = json?["message"].string else { self = .unknown; return }
//        
//        switch message.uppercased() {
//            case "INVALID_LENGTH", "INVALID_CHARACTER", "INVALID_PWM_FILTERED": self = .invalid
//            case "INVALID_DUPLICATED": self = .occupied
//            default: self = .unknown
//        }
//    }
    
    init?(error: NSError?) {
        guard let errorCode = error?.code else { return nil }
        
        switch errorCode {
        case 60001: self = .unknown
        default: return nil
        }
    }
}


extension GPEditProfileViewController {
    
    // 프로필 수정사항 업로드
    func updateProfileInfo(success: @escaping (() -> Void), failure: ((NicknameError?) -> Void)?) {
        showIndicator()
        
        if let newImage = profileModelEdited?.profileImageInstance {
            // 이미지 업로드
//            requestUploadingImage(image: newImage, success: { [weak self] model in
//                self?.profileModelEdited?.profileImageUrl = model.url
//                self?.profileModelEdited?.profileImageUrlWithDomain = model.imageUrl
//
//                // 프로필 업로드
//                self?.requestUpdatingProfile(success: success, failure: failure, finally: { [weak self] in
//                    guard self?.isViewLoaded == true else { return }
//                    self?.hideIndicator()
//                })
//                }, failure: { [weak self] _ in
//                    failure?(nil)
//
//                    guard self?.isViewLoaded == true else { return }
//                    self?.hideIndicator()
//            })
        } else {
            // 업로드할 이미지가 없으면 바로 프로필 업로드 진행
            requestUpdatingProfile(success: success, failure: failure, finally: { [weak self] in
//                guard self?.isViewLoaded == true else { return }
                self?.hideIndicator()
            })
        }
    }
    
    // 이미지 업로드
//    fileprivate func requestUploadingImage(image: UIImage, success: @escaping ((GPPhotoInfraResponseModel) -> Void), failure: ((NSError?) -> Void)?) {
//        // 이미지 업로더 생성에 실패하면 실패 처리하고 이벤트 종료
//        guard let imageUploader = imageUploader ?? GPImageUploader() else {
//            failure?(nil)
//            return
//        }
//
//        imageUploader.upload(image: image, success: { (model) in
//            Log.info?.message("debug: image upload succeed = \(model.imageUrl)")
//
//            // full path가 아닌 domain이 제외된 url을 전달한다.
//            success(model)
//        }, failure: failure)
//    }
    
    // 프로필 수정 API
    private func requestUpdatingProfile(success: @escaping (() -> Void), failure: ((NicknameError?) -> Void)?, finally: (() -> Void)?) {
        guard let editedModel = profileModelEdited else { failure?(.unknown); return }
        
//        GPProfileNetworkModel.updateProfile(model: editedModel, success: success, failure: failure, finally: finally)
    }
}

// MARK:- 가입

extension GPEditProfileViewController {
    
    // 가입
    func registerService(success: @escaping (() -> Void), failure: ((NSError?) -> Void)?) {
        showIndicator()
        
        if let newImage = profileModelEdited?.profileImageInstance {
            // 이미지 업로드 후 가입
//            requestUploadingImage(image: newImage, success: { [weak self] model in
//                // 업로드에 성공하면 edit model에서 이미지는 제거해서 중복 업로드 방지
//                self?.profileModelEdited?.profileImageInstance = nil
//                self?.profileModelEdited?.profileImageUrl = model.url
//                self?.profileModelEdited?.profileImageUrlWithDomain = model.imageUrl
//
//                // 가입
//                self?.requestRegisterService(success: success, failure: failure, finally: { [weak self] in
//                    guard self?.isViewLoaded == true else { return }
//                    self?.hideIndicator()
//                })
//                }, failure: { [weak self] error in
//                    failure?(error)
//
//                    guard self?.isViewLoaded == true else { return }
//                    self?.hideIndicator()
//            })
        } else {
            // 이미지 변경사항이 없으면 바로 가입
            requestRegisterService(success: success, failure: failure, finally: { [weak self] in
//                guard self?.isViewLoaded == true else { return }
                self?.hideIndicator()
            })
        }
    }
    
    private func requestRegisterService(success: @escaping (() -> Void), failure: ((NSError?) -> Void)?, finally: (() -> Void)?) {
        guard let model = profileModelEdited else {
            failure?(nil)
            return
        }
        
//        GPMemberNetworkModel.joinService(nickName: model.nickname, profileImage: model.profileImageUrl, profileText: model.introduce, success: { [weak self] _ in
//            self?.performSegue(withIdentifier: "segueToFeedFromEditProfile", sender: nil)
//            finally?()
//            }, failure: { error in
//                failure?(error)
//                finally?()
//        })
    }
}
