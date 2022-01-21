//
//  BaseMemoryController.swift
//  seventyDays
//
//  Created by 최일용 on 2019/12/05.
//  Copyright © 2019 CISTREE. All rights reserved.
//

import Foundation
//import AWSAppSync

extension UIView {
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.borderColor = color.cgColor
      } else {
        layer.borderColor = nil
      }
    }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable
  var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  var shadowColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.shadowColor = color.cgColor
      } else {
        layer.shadowColor = nil
      }
    }
  }
}

class BaseMemoryViewController : ViewController {
    
    
}

class BaseViewController : ViewController {
    
    
}

class GPBaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // ACE Log 전송
//        if self is GPSendPageViewProtocol { sendPageViewId() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // ACE Log 전송
//        if self is GPSendPageViewProtocol { sendPageViewId() }
    }
    
    func sendPageViewId() {
//        guard let screenId = (self as? GPSendPageViewProtocol)?.screenId else { return }
//        GPAceManager.site(screenId)
    }
    
    var selfShouldBeRootViewController: Bool {
        return false
    }
    
    // Drawer 노출시 status bar 숨김처리
//    override var prefersStatusBarHidden: Bool {
////        guard let drawerAnimator = (navigationController?.presentedViewController as? GPDrawerViewController)?.animationController else { return false }
//
//        // TransitionAnimator에서 애니메이션 시작 후에 숨김/노출값 반영
//        return drawerAnimator.isPresenting == drawerAnimator.isAnimating
//    }
    
    // status bar 노출/숨김시 애니메이션 처리
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
//        if willReleaseView() {
//            view = nil
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Drawer버튼 사용하는 화면인 경우 버튼 이미지 업데이트
//        updateDrawerButtonImageIfAvailable()
        
        // 커스텀 네비게이션바에 viewController의 reference를 연결
        connectReferenceToCustomNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // support swipe-back
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if selfShouldBeRootViewController {
            removeOtherViewControllers()
        }
    }
    
    private func removeOtherViewControllers() {
//        if UIApplication.rootViewController() == navigationController {
//            navigationController?.viewControllers = [self]
//        } else {
//            // 앱 스펙상으로 볼 때, intro화면과 feed화면은 항상 root에 존재해야 한다.
//            Log.error?.message("\(self) scene is not at the root")
//        }
    }
    
    @IBAction func popViewController(segue: UIStoryboardSegue?) {
        navigationController?.popViewController(animated: true)
    }
    
    private func connectReferenceToCustomNavigationBar() {
        if let navigationBar = view.subviews.filter({$0 is GPCustomNavigationBar}).first as? GPCustomNavigationBar {
            navigationBar.viewController = self
        }
    }
}

extension GPBaseViewController: UIGestureRecognizerDelegate {
    
    // Swipe-back 지원 처리
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        // Drawer button이 노출된 상황에서는 swipe-back 미지원
////        let drawerButtonVisible = (self as? GPDrawerSupportProtocol)?.isDrawerButtonVisible == true
//        
//        // 뒤에 깔린 viewController가 없을 경우에는 미지원
//        let hasOneViewController = navigationController?.viewControllers.count == 1
//        
//        return !(drawerButtonVisible || hasOneViewController)
//    }
}
