//
//  GPEditProfileViewController.swift
//  GP
//
//  Created by NAVER on 2017. 5. 8..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import Foundation
import Lottie
//import EZAlertController
//import CleanroomLogger

enum GPNicknameValidationState: Int {
    case unknown  // validation API 확인 안됨. 처음 진입시 기본값.
    case empty    // 입력한 값이 없음
    case occupied // 중복
    case invalid  // 사용불가. 추후 API 에러타입에 따라 세분화할수 있음.
    case valid
    
    // 닉네임 에러코드값을 기반으로 state를 결정한다.
    init(nicknameError: NicknameError?) {
        // error가 nil이면 valid로 판단.
        guard let nicknameError = nicknameError else {
            self = .valid
            return
        }
        
        // invalid 에러 뿐 아니라 알 수 없는 에러는 전부 사용 불가능한 닉네임으로 처리한다.
        switch nicknameError {
        case .occupied: self = .occupied
        default:        self = .invalid
        }
    }
    
    func isUploadable() -> Bool {
        switch self {
        case .unknown, .valid:
            return true
            
        default:
            return false
        }
    }
}

let GPProfileHasUpdatedNotification = "GPProfileHasUpdatedNotification"

class GPEditProfileViewController: GPBaseViewController {
    
    @IBOutlet weak var customNavigationBar: GPCustomNavigationBar!
    @IBOutlet weak var customNavigationBarTitle: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var profileImageChangeButton: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageViewTopLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameTextInfoLabel: UILabel!
    
    @IBOutlet weak var profileDescriptionTextView: UITextView!
    @IBOutlet weak var profileDescriptionDeleteButton: UIButton!
    @IBOutlet weak var profileDescriptionUnderbar: UIImageView!
    @IBOutlet weak var profileDescriptionHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileDescriptionUnderbarTopLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var profileTermsInfoLabel: UILabel!
    
    public var completionHandler: ((_ resultImage:UIImage) -> Void)!
    // ACE Log 관련
    var pvSent = false
    override func sendPageViewId() {
        guard !pvSent else { return }
        
//        GPAceManager.site(isEditProfileType ? .editprofile : .setprofile)
        pvSent = true
    }
    
    /// 이미 가입된 사용자의 프로필 편집모드이면 true, 가입 단계에서 프로필 최초 설정하는 모드이면 false.
    var isEditProfileType: Bool = true
    
//    weak var loadingView: LOTAnimationView?
    let profileDescDefaultString: String = NSLocalizedString("edit_profile_introduce_is_empty", comment: "")

    var profileModelOrigin: GPProfileModel? {
        didSet {
            // 원본 모델이 할당되었으면 편집용 모델로 복사
            profileModelEdited = profileModelOrigin
        }
    }
    var profileModelEdited: GPProfileModel?
//    var imageUploader = GPImageUploader()
    
    var nickNameCheckTimer: Timer?
    let nickNameCheckTimerTimeInterval: Double = 1.0
    public var nicknameState: GPNicknameValidationState = .unknown {
        didSet {
            // nicknameTextInfoLabel과 done button 업데이트
            updateNicknameState(state: nicknameState)
        }
    }
    
    // MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeModel()
        initializeSubviews()
        
        profileImageView.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.backgroundColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ACE Log 전송
        sendPageViewId()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: .UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK:- Navigation Button Event

extension GPEditProfileViewController {
    
    @IBAction func onTouchedBack(button: UIButton) {
        
        self.hideKeyboard()
        
        // 버튼 중복터치 방지
        self.activeDoneButton(isActive: false)
        self.activeButtons(isActive: false)
        
        // 회원가입Scene인지, 프로필수정Scene인지에 따라 다른 메소드 호출
        if isEditProfileType {
            onTouchedBackButtonOnEditingProfileScene()
        } else {
            onTouchedBackButtonOnSigningUpScene()
        }
    }
    
    private func onTouchedBackButtonOnEditingProfileScene() {
        if profileModelOrigin == profileModelEdited {
            self.navigationController?.popViewController(animated: true)
        } else {
            displayUploadChangedProfileAlert()
        }
    }
    
    private func onTouchedBackButtonOnSigningUpScene() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTouchedEditProfileDone(button: UIButton) {
        
        if profileDescriptionTextView.isFirstResponder {
            profileDescriptionTextView.resignFirstResponder()
        }
        
        if profileDescriptionTextView.text != profileDescDefaultString {
            profileModelEdited?.introduce = profileDescriptionTextView.text
        }
        
        if nickNameTextField.isFirstResponder {
            nickNameTextField.resignFirstResponder()
            profileModelEdited?.nickname = nickNameTextField.text ?? ""
            nicknameState = (nickNameTextField.text?.count ?? 0) == 0 ? .empty : .unknown
        }
        
        // 닉네임이 업로드 불가능한 상태이면 API 호출 없이 바로 alert 노출
        guard nicknameState.isUploadable() == true else {
            displayErrorAlert(state: nicknameState)
            return
        }
        
        // 버튼 중복터치 방지
        self.activeDoneButton(isActive: false)
        self.activeButtons(isActive: false)
        
        // 회원가입Scene인지, 프로필수정Scene인지에 따라 다른 메소드 호출
        isEditProfileType == true ? onTouchedDoneButtonOnEditingProfileScene() : onTouchedDoneButtonOnSigningUpScene()
    }
    
    func sendProfileHasUpdatedNotification() {
        NotificationCenter.default.post(name: NSNotification.Name.init(GPProfileHasUpdatedNotification), object: profileModelEdited)
    }
    
    private func onTouchedDoneButtonOnEditingProfileScene() {
        
//        LoginViewController.updateProfileImage(image:)
        let pImage : UIImage = self.profileImageView.image!
        self.completionHandler(pImage)
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        return
        //프로파일 변경여부 처리
        if profileModelOrigin == profileModelEdited {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.updateProfileInfo(success: { [weak self] in
//                Log.info?.message("succeed to update profile÷ info")÷
                
                // 프로필 수정에 성공하면 notification 발송
                self?.sendProfileHasUpdatedNotification()
                
                self?.navigationController?.popViewController(animated: true)
                }, failure: { [weak self] nicknameError in
                    guard self?.isViewLoaded == true else { return }
                    
                    let nicknameState = GPNicknameValidationState(nicknameError: (nicknameError ?? .unknown))
                    self?.displayErrorAlert(state: nicknameState)
                    self?.updateNicknameState(state: nicknameState)
                    self?.activeButtons(isActive: true)
            })
        }
    }
    
    private func onTouchedDoneButtonOnSigningUpScene() {
        registerService(success: { [weak self] in
            // 서비스 가입에 성공하면 notification 발송
            self?.sendProfileHasUpdatedNotification()
            
            self?.performSegue(withIdentifier: "segueToFeedFromEditProfile", sender: nil)
            }, failure: { [weak self] error in
//                Log.error?.message("failed to sign up. error = \(error?.description ?? "nil")", errorCode: String(describing: self))
                guard self?.isViewLoaded == true else { return }
                
                self?.displayErrorAlert(state: GPNicknameValidationState(nicknameError: .unknown))
                
                self?.activeDoneButton(isActive: self?.nicknameState.isUploadable() ?? false)
                self?.activeButtons(isActive: true)
        })
    }
}

// MARK: - UIAlertController

extension GPEditProfileViewController {
    
    // nickname state에 따라 오류 alert을 노출한다.
    func displayErrorAlert(state: GPNicknameValidationState) {
        
        let alertMessage: String = {
            switch nicknameState {
            case .empty:    return NSLocalizedString("edit_profile_alert_error_user_name_is_empty", comment: "")
            case .occupied: return NSLocalizedString("edit_profile_alert_error_user_name_is_use", comment: "")
            case .invalid:  return NSLocalizedString("edit_profile_alert_error_user_name_impossible", comment: "")
                
            default:        return NSLocalizedString("error_app_service_retry", comment: "")
            }
        }()
        
//        EZAlertController.simpleAlert(message: alertMessage, from: self)
    }
    
    func displayUploadChangedProfileAlert() {
        
        let alertMessage = NSLocalizedString("edit_profile_alert_do_save", comment: "")
        
        let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("edit_profile_alert_do_back", comment: ""), style: .destructive, handler: { (_) in
            // alert이 dismiss된 후에 pop해서 animation 효과가 자연스럽도록 처리
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("edit_profile_alert_save", comment: ""), style: .default, handler: { [weak self] (_) in
            //saveApi
            //profileModelEdited
            //-------------------------------------
            self?.updateProfileInfo(success: { [weak self] in
//                Log.info?.message("succeed to update profile info")
                
                // 프로필 수정에 성공하면 notification 발송
                self?.sendProfileHasUpdatedNotification()
                
                self?.navigationController?.popViewController(animated: true)
                }, failure: { [weak self] nicknameError in
//                    Log.warning?.message("fail to update profile info")
                    guard self?.isViewLoaded == true else { return }
                    
                    self?.displayErrorAlert(state: GPNicknameValidationState(nicknameError: nicknameError))
                    
                    self?.activeDoneButton(isActive: self?.nicknameState.isUploadable() ?? false)
                    self?.activeButtons(isActive: true)
            })
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
