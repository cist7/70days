//
//  GPEditProfileViewController+View.swift
//  GP
//
//  Created by Nakyung Lim on 2017. 5. 27..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import Foundation
import Lottie
//import EZAlertController
//import CleanroomLogger
import MobileCoreServices
import Photos

// MARK:- Views

extension GPEditProfileViewController {
    
    // MARK: Initialize Views
    
    func initializeSubviews() {
        initializeLoadingIndicator()
        initNickNameView()
        
//        customNavigationBarTitle.setNavigation(title: isEditProfileType ? NSLocalizedString("settings_edit_profile", comment: "") : NSLocalizedString("edit_profile_join_title", comment: ""))
//
//        doneButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
//        nickNameTextField.font = UIFont.font(type: .sanFrancisco, size: 15, weight: UIFontWeightRegular)
//        profileDescriptionTextView.font = UIFont.font(type: .sanFrancisco, size: 15, weight: UIFontWeightRegular)
        
        nickNameTextField.applyCustomClearButton()
        if let clearButton = nickNameTextField.rightView as? UIButton {
//            clearButton.addTarget(self, action: #selector(clearClicked(sender:)), for: .touchUpInside)
        }

//        nickNameTextField.tintColor = UIColor.init(red: 254, green: 126, blue: 162, transparency: 1.0)
//        profileDescriptionTextView.tintColor = UIColor.init(red: 254, green: 126, blue: 162, transparency: 1.0)
        
        profileDescriptionTextView.textContainerInset = UIEdgeInsets.zero
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mainScrollView.addGestureRecognizer(tapGesture)
        
//        profileImageView.loadImage(urlString: profileModelOrigin?.profileImageUrlWithDomain?.resized(.square150), placeHolder: #imageLiteral(resourceName: "basicProfile"))
        
        profileTermsInfoLabel.text = isEditProfileType ? nil : NSLocalizedString("edit_profile_join_guide", comment: "")
        
        profileTermsInfoLabel.attributedText = applyLetterSpacing(attrString: profileTermsInfoLabel.attributedText, spacingValue: -0.3)
        
        //프로필편집일경우 하단 설명문구 숨김
        profileTermsInfoLabel.isHidden = isEditProfileType ? true : false
        let displayIntroduceTextField = isEditProfileType == true && profileModelOrigin?.isContentCreator == true
        profileImageViewTopLayoutConstraint.constant = displayIntroduceTextField ? 30.0 : 50.0
        hiddenProfileDescriptionView(isHidden: displayIntroduceTextField == false)
        
        if displayIntroduceTextField {
            initProfileDescriptionTextView()
        }
        
        nickNameTextField.attributedText = applyLetterSpacing(attrString: nickNameTextField.attributedText, spacingValue: -0.2)
        nickNameTextInfoLabel.attributedText = applyLetterSpacing(attrString: nickNameTextInfoLabel.attributedText, spacingValue: -0.2)
        profileDescriptionTextView.attributedText = applyLetterSpacing(attrString: profileDescriptionTextView.attributedText, spacingValue: -1.2)
    }
    
    func applyLetterSpacing(attrString: NSAttributedString?, spacingValue: CGFloat) -> NSMutableAttributedString? {
        
        guard let baseAttrString: NSAttributedString = attrString else { return nil }
        let attributeString = NSMutableAttributedString(attributedString: baseAttrString)
        attributeString.addAttributes([NSAttributedString.Key.kern: spacingValue], range: NSRange(location: 0, length: attributeString.length))
        
        return attributeString
    }
    
    @objc func hideKeyboard() {
        nickNameTextField.resignFirstResponder()
        profileDescriptionTextView.resignFirstResponder()
        
        // text 변경사항을 model에 반영
        if let newNickname = nickNameTextField.text, profileModelEdited?.nickname != newNickname {
            profileModelEdited?.nickname = newNickname
            checkNickName()
        }
    }
    
    private func initNickNameView() {
        nickNameTextField.text = profileModelOrigin?.nickname
        nickNameTextField.placeholder = NSLocalizedString("edit_profile_user_name", comment: "")
    }
    
    func initProfileDescriptionTextView() {
        
        let textView: UITextView! = profileDescriptionTextView
        profileDescriptionDeleteButton.isHidden = true

        if (profileModelOrigin?.introduce?.count ?? 0) > 0 {
            profileDescriptionTextView.text = profileModelOrigin?.introduce
            let textViewMaximumViewHeight: CGFloat = 66
            let fixedWidth = textView.frame.size.width
            textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = textView.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
//            textView.textColor = UIColor.init(red: 0, green: 0, blue: 0, transparency: 1.0)

            if newFrame.height <= textViewMaximumViewHeight {
                self.profileDescriptionHeightLayoutConstraint.constant = newFrame.height
                textView.isScrollEnabled = false
//                textView.scrollToTop(animated: false)
                textView.contentOffset = CGPoint(x: 0.0, y: 0.0)
            } else {
                textView.isScrollEnabled = true
                self.profileDescriptionHeightLayoutConstraint.constant = textViewMaximumViewHeight
            }
        } else {
            profileDescriptionTextView.text = profileDescDefaultString
//            textView.textColor = UIColor.init(red: 0, green: 0, blue: 0, transparency: 0.2)
        }
    }
    
    private func hiddenProfileDescriptionView(isHidden: Bool) {
        profileDescriptionTextView.isHidden = isHidden
        profileDescriptionUnderbar.isHidden = isHidden
        profileDescriptionDeleteButton.isHidden = isHidden
    }
    
    // MARK: Loading Indicator
    
    private func initializeLoadingIndicator() {
//        guard let lottieView = LOTAnimationView.createCommonLoadingIndicator() else { return }
//
//        view.addSubview(lottieView)
//        lottieView.anchorCenterSuperview()
//
//        loadingView = lottieView
    }
    
    func showIndicator() {
//        loadingView?.showIndicator()
    }
    
    func hideIndicator() {
//        loadingView?.hideIndicator()
    }
    
    // MARK: Done Button
    
    func activeDoneButton(isActive: Bool) {
        doneButton.isEnabled = isActive
        
        if isActive {
            doneButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            doneButton.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }
    
    func activeButtons(isActive: Bool) {
        backButton.isEnabled = isActive
        profileImageChangeButton.isEnabled = isActive
    }
    
    // MARK: 키보드 노출시 뷰 처리
    func keyboardWillShowNotification(notification: Notification) {
        
        var activeField: UIView?
        //키보드에 가려지지 않으면 그대로 둔다.
        var contentOffset: CGFloat = 0
        var contentOffsetExtended: CGFloat = 34 //키보드 하단 53픽셀 위치
        let textViewMaximumViewHeight: CGFloat = 66
        
        if nickNameTextField.isFirstResponder {
            activeField = nickNameTextField
        } else {
            activeField = profileDescriptionTextView
            contentOffsetExtended += textViewMaximumViewHeight
        }
        
        let kbSize = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
        
        let activeFrame = (activeField?.frame.origin.y)!+(activeField?.frame.height)!
        let keyboardDepth = mainScrollView.frame.size.height - (kbSize?.height)!
        
        //현재 포커싱된뷰가 키보드에 가려지면 가려진만큼 +(contentOffsetExtended 조정값 만큼)오프셋을 올린다.
        if keyboardDepth <= activeFrame+contentOffsetExtended {
            contentOffset = activeFrame - keyboardDepth
            contentOffset += contentOffsetExtended
        }
    
        mainScrollView.setContentOffset(CGPoint(x: 0, y: contentOffset), animated: true)
    }
    
    func keyboardWillHideNotification(notification: Notification) {
        mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

// MARK:- Image 관련 기능

extension GPEditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileImageCropViewControllerDelegate {
    
    @IBAction func didSelectProfileCameraButton() {
        
        self.hideKeyboard()
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("edit_profile_album", comment: ""), style: .default, handler: { [weak self] (_) in
            self?.checkPhotoPermission()
        }))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("edit_profile_camera", comment: ""), style: .default, handler: { [weak self] (_) in
            self?.checkCameraPermission()
        }))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: { [weak self] _ in
            //Delete Action
            self?.deleteProfileImage(image: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func checkCameraPermission () {
        GPMediaAuthManager.shared.checkCameraPermission(onPermit: {() -> Void in
            self.presentImagePicker(type: .camera)
        },
                                                        onDenied: {() -> Void in
                                                            
        })
    }
    
    func checkPhotoPermission () {
        GPMediaAuthManager.shared.checkPhotoPermission(onPermit: {() -> Void in
            self.presentImagePicker(type: .photoLibrary)
        },
                                                       onDenied: {() -> Void in
                                                        
        })
    }
    
    func presentImagePicker(type: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = type
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지 첨부 제한용량 확인. 용량이 너무 크면 메모리 사용량을 버티지 못해서 OS가 app을 terminate한다.
        fetchImageSize(from: info, result: { [weak self] imageSizeInKB in
            // 용량이 15mb를 초과하면 alert 노출하고 이미지 선택 차단
            if (imageSizeInKB ?? 0) > 1024.0 * 15 {
//                EZAlertController.detailAlert(message: NSLocalizedString("edit_profile_alert_too_large_image", comment: ""), cancelBlock: nil)
                
                return
            }
            
            guard let image = info[.originalImage] as? UIImage else { return }
            
            // 이미지 사이즈 감소. 1100, 1200 정도에서 1000 으로 줄이는건 큰 의미가 없다고 판단, 1500 이상이면 1000으로 줄인다.
            
            let resizedImage = (image.size.width > 1500.0) ? image.scaled(toWidth: 1000.0) : image
            picker.dismiss(animated: true, completion: { [weak self] in
                self?.presentCropImageViewController(image: resizedImage ?? image)
            })
        })
    }
    
    /// UIImagePicker에서 선택한 이미지의 info를 기반으로 용량을 확인한다. result closure의 Int는 kb단위 이미지용량
    private func fetchImageSize(from info: [UIImagePickerController.InfoKey: Any], result: @escaping ((Double?) -> Void)) {
        if let asset = fetchAsset(from: info) {
            // PHAsset을 가져와서 용량을 구한다
            let option = PHImageRequestOptions()
            option.deliveryMode = .fastFormat
            option.resizeMode = .fast
            
            PHImageManager.default().requestImageData(for: asset, options: option, resultHandler: { (imageData, _, _, _) in
                result(Double(imageData?.count ?? 0) / 1024.0)
            })
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // reference url 정보가 없으면 직접 이미지를 추출해서 용량 확인. 이 코드를 타는 일은 아마 없을 것임.
            result(Double(image.kilobytesSize))
        } else {
            result(nil)
        }
    }
    
    private func fetchAsset(from info: [UIImagePickerController.InfoKey: Any]) -> PHAsset? {
        guard let url = info[UIImagePickerController.InfoKey.referenceURL] as? URL, let identifier = url.assetIdentifier else { return nil }
        
        return PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil).firstObject
    }
    
    func presentCropImageViewController(image: UIImage) {
        guard let vc = UIStoryboard(name: "ProfileImageCropViewController", bundle: nil).instantiateInitialViewController() as? ProfileImageCropViewController else { return }
        
        vc.image = image
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func didCropProfileImage(with image: UIImage!) {
        changeProfileImage(image: image)
    }
    
    func deleteProfileImage(image: UIImage?) {
        profileImageView.image = #imageLiteral(resourceName: "basicProfile")
        profileModelEdited?.profileImageUrlWithDomain = nil
        profileModelEdited?.profileImageUrl = nil
        profileModelEdited?.profileImageInstance = nil
    }
    
    func changeProfileImage(image: UIImage?) {
        profileImageView.image = image
        profileModelEdited?.profileImageUrlWithDomain = nil
        profileModelEdited?.profileImageUrl = nil
        profileModelEdited?.profileImageInstance = image
    }
}

extension URL {
    
    /// Photos asset에서 identifier로 사용하는 부분 추출
    fileprivate var assetIdentifier: String? {
        return absoluteString.components(separatedBy: "id=").last?.components(separatedBy: "&").first
    }
}

// MARK:- 닉네임 관련 기능

extension GPEditProfileViewController: UITextFieldDelegate {
    
    func clearClicked(sender: UIButton) {
        nickNameTextField.text = ""
        activeDoneButton(isActive: false)
    }

    // 닉네임 사용가능여부 상태값이 바뀌면 관련 뷰 업데이트
    func updateNicknameState(state: GPNicknameValidationState) {
        activeDoneButton(isActive: state.isUploadable())
        
        switch(state) {
        case .unknown, .empty:
            nickNameTextInfoLabel.text = nil
            
        case .occupied:
            nickNameTextInfoLabel.text = NSLocalizedString("edit_profile_user_name_in_use", comment: "")
            nickNameTextInfoLabel.textColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 1.0)
            
        case .invalid:
            nickNameTextInfoLabel.text = NSLocalizedString("edit_profile_user_name_impossible", comment: "")
            nickNameTextInfoLabel.textColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 1.0)
            
        case .valid:
//            nickNameTextInfoLabel.textColor = UIColor.init(red: 254, green: 150, blue: 179, transparency: 1.0)
            nickNameTextInfoLabel.text = NSLocalizedString("edit_profile_user_name_possible", comment: "")
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nicknameMaximumLength = 24
        let replacementStringLength = (textField.text?.count ?? 0) + string.count
        let isPressedBackspaceKey = string.count <= 0
        
        if  replacementStringLength > nicknameMaximumLength && !isPressedBackspaceKey {
            //닉네임 24글자 이상일경우 얼럿없이 제한.
            return false
        }
        
        stopTimer()
        
        nicknameState = .unknown
        
        startTimer()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.text?.count ?? 0) > 0 {
            profileModelEdited?.nickname = textField.text!
        }
        textField.resignFirstResponder()
        return true
    }
    
    // 닉네임 텍스트를 입력하면 1초 후 validation API 호출
    func startTimer() {
        if nickNameCheckTimer == nil {
            nickNameCheckTimer =  Timer.scheduledTimer(
                timeInterval: nickNameCheckTimerTimeInterval,
                target      : self,
                selector    : #selector(checkNickName),
                userInfo    : nil,
                repeats     : false)
        }
    }
    
    func stopTimer() {
        nickNameCheckTimer?.invalidate()
        nickNameCheckTimer = nil
    }
    
    @objc func checkNickName() {
        stopTimer()
        
        checkNicknameValidation(success: { [weak self] checkedNickname, state in
//            Log.info?.message("succeed to update profile info")
            
            // 유효성 체크를 한 닉네임이 현재 텍스트필드에 입력된 값과 다르면 이벤트 무시
            guard checkedNickname == self?.nickNameTextField.text else {
                self?.nicknameState = .unknown
                return
            }
            
            self?.profileModelEdited?.nickname = checkedNickname
            self?.nicknameState = state
            }, failure: nil)
    }
}

// MARK: - 소개글 관련 기능

extension GPEditProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == profileDescDefaultString {
            textView.text = ""
        }
        
        profileDescriptionDeleteButton.isHidden = false
//        textView.alpha = 1
//        textView.textColor = UIColor.init(red: 0, green: 0, blue: 0, transparency: 1.0)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        profileDescriptionDeleteButton.isHidden = true
        
        if textView.text.count == 0 {
            textView.text = profileDescDefaultString
            profileModelEdited?.introduce = ""
//            textView.textColor = UIColor.init(red: 0, green: 0, blue: 0, transparency: 0.2)
        } else {
//            textView.textColor = UIColor.init(red: 0, green: 0, blue: 0, transparency: 1.0)
            profileModelEdited?.introduce = textView.text
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let introduceMaximumLength = 100
        let replacementStringLength = textView.text.count + text.count
        let isPressedBackspaceKey = text.count <= 0
        
        if  replacementStringLength > introduceMaximumLength && !isPressedBackspaceKey {
            //100글자 이상일경우 얼럿없이 제한.
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        resizeTextView(textView)
    }

    fileprivate func resizeTextView(_ textView: UITextView) {
        
        let textViewMaximumViewHeight: CGFloat = 66
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)

        if newFrame.height <= textViewMaximumViewHeight {
            self.profileDescriptionHeightLayoutConstraint.constant = newFrame.height
            textView.isScrollEnabled = false
//            textView.scrollsToTop
//            textView.scrollToTop(animated: false)
            
            textView.contentOffset = CGPoint(x: 0.0, y: 0.0)
        } else {
            textView.isScrollEnabled = true
        }
    }
    
    @IBAction func clearTextView() {
//        profileDescriptionTextView.clear()
        resizeTextView(profileDescriptionTextView)
    }
}

extension UITextField {
    func applyCustomClearButton() {
        clearButtonMode = .never
        rightViewMode   = .whileEditing
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 22))

        clearButton.setImage(UIImage.init(named: "iconErase"), for: .normal)
        clearButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 2, right: 0)
        self.rightView = clearButton
        self.clipsToBounds = false
    }
}

//
class GPMediaAuthManager {
    static let shared = GPMediaAuthManager()
    
    /**
     사진첩 권한이 있는지 확인.
     
     - parameter onPermit: 만약 권한이 있다면 실행시킬 클로져
     - parameter onDeny:   권한이 없다면 실행시킬 클로져
     */
    func checkPhotoPermission(onPermit onPermitClosure: (() -> Void)? = nil,
                              onDenied onDeniedClosure: (() -> Void)? = nil) {
        
        switch PHPhotoLibrary.authorizationStatus() {
        // 최초로 권한을 물어보는 경우,
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    DispatchQueue.main.async { onPermitClosure?() }
                case .denied: fallthrough
                case .restricted:
                    DispatchQueue.main.async { onDeniedClosure?() }
                case .notDetermined:
                    return
                @unknown default:
                    fatalError()
                }
            }
            
        // 권한을 거절했던 경우 권한을 재설정할 것인지 물어본다.
        case .restricted, .denied:
            askReEnableAuth(alertTitle: Bundle.main.object(forInfoDictionaryKey: "NSPhotoLibraryUsageDescription") as? String ?? "사진을 등록하기 위해 사진첩 권한이 필요합니다.")
            onDeniedClosure?()
            
        // 권한이 있는 경우
        case .authorized:
            onPermitClosure?()
        @unknown default:
            fatalError()
        }
    }
    
    /**
     카메라 권한이 있는지 확인.
     카메라가 지원되지 않는 장비일 경우에는 onDenyClosure만 실행하고 메소드가 종료된다.
     
     - parameter onPermit: 만약 권한이 있다면 실행시킬 클로져
     - parameter onDeny:   권한이 없다면 실행시킬 클로져
     */
    func checkCameraPermission(onPermit onPermitClosure: (() -> Void)? = nil,
                               onDenied onDeniedClosure: (() -> Void)? = nil) {
        // 카메라를 지원하지 않는 단말은 권한 거부 클로져만 수행하고 메소드 종료
        guard deviceSupportsCamera() else {
            onDeniedClosure?()
            
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        // 최초로 권한을 물어보는 경우,
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (authorized) in
                if authorized {
                    DispatchQueue.main.async { onPermitClosure?() }
                } else {
                    DispatchQueue.main.async { onDeniedClosure?() }
                }
            }
            
        // 권한을 거절했던 경우 권한을 재설정할 것인지 물어본다.
        case .restricted, .denied:
            askReEnableAuth(alertTitle: Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") as? String ?? "사진을 촬영하기 위해 카메라 권한이 필요합니다.")
            onDeniedClosure?()
           
        // 권한이 있는 경우
        case .authorized:
            onPermitClosure?()
        @unknown default:
            fatalError()
        }
    }
    
    private func deviceSupportsCamera() -> Bool {
//        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            _ = try AVCaptureDeviceInput(device: (device ?? nil)!)
        } catch let error as NSError {
            
            let code  = error.code // 단순히 권한을 거부한 경우에도 error가 catch된다. 따라서 code로 분기처리해야함
            
            // 장비가 카메라를 지원하지 않음 Ex) 시뮬레이터
            if code == -11814 {
//                Log.info?.message("This device does not support camera")
                
                return false
            } else {
                return true
            }
        }
        
        return true
    }

    // 이전에 미디어 접근 권한을 거절한 경우, 재설정할 것인지를 묻는다.
    private func askReEnableAuth(alertTitle: String) {
//        EZAlertController.detailAlert(message: alertTitle,
//                                          acceptMessage: NSLocalizedString("ok", comment: ""),
//                                          cancelMessage: NSLocalizedString("cancel", comment: ""),
//                                          acceptBlock: { [weak self] in
//                                            self?.goToReEnable()
//        })
    }

    // 권한을 재설정하러 이동한다.
    private func goToReEnable() {
        let url = URL(string: UIApplication.openSettingsURLString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else if #available(iOS 9.0, *) {
            UIApplication.shared.openURL(url)
        }
    }
}


public extension UIImage {
    
    /// SwifterSwift: Size in bytes of UIImage
    var bytesSize: Int {
        return self.jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    /// SwifterSwift: Size in kilo bytes of UIImage
    var kilobytesSize: Int {
        return bytesSize / 1024
    }
    
    /// SwifterSwift: UIImage with .alwaysOriginal rendering mode.
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    /// SwifterSwift: UIImage with .alwaysTemplate rendering mode.
    var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
}


// MARK: - Methods
public extension UIImage {
    
    /// SwifterSwift: Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    /// SwifterSwift: Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return self.jpegData(compressionQuality: quality)
    }
    
    /// SwifterSwift: UIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.height < size.height && rect.size.height < size.height else {
            return self
        }
        guard let image: CGImage = cgImage?.cropping(to: rect) else {
            return self
        }
        return UIImage(cgImage: image)
    }
    
    /// SwifterSwift: UIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - orientation: optional UIImage orientation (default is nil).
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toHeight: CGFloat, with orientation: UIImage.Orientation? = nil) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: toHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// SwifterSwift: UIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - orientation: optional UIImage orientation (default is nil).
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toWidth: CGFloat, with orientation: UIImage.Orientation? = nil) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: toWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// SwifterSwift: UIImage filled with color
    ///
    /// - Parameter color: color to fill image with.
    /// - Returns: UIImage filled with given color.
    func filled(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = self.cgImage else {
            return self
        }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}


// MARK: - Initializers
public extension UIImage {
    
    /// SwifterSwift: Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
    
}
