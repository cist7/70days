//
//  CTNavigationController.swift
//  seventyDays
//
//  Created by 최일용 on 2019/12/26.
//  Copyright © 2019 CISTREE. All rights reserved.
//

import Foundation
import UIKit


class CTNavigationController: UINavigationController {
    
    override var description: String {
        return super.description + " // ViewControllers: " + createViewControllerStackInfo()
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let poppedViewControllers = super.popToRootViewController(animated: animated)
        
        updateStackInfoToNeloField()
        
        return poppedViewControllers
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        updateStackInfoToNeloField()
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let popped = super.popViewController(animated: animated)
        
        updateStackInfoToNeloField()
        
        return popped
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = false
    }
}

extension CTNavigationController {
    
    // Nelo에 viewController 스택 기록 추가
    fileprivate func updateStackInfoToNeloField() {
//        NeloLog.setCustomField(description, forKey: "ViewStack")
        
//        if let viewController = viewControllers.last {
//            NeloLog.setCustomField(NSStringFromClass(viewController.classForCoder), forKey: "CurentViewController")
//        }
    }
    
    // 삭제된 글의 엔드페이지를 스택에서 제거. 현재 화면인 경우에는 자체적으로 dismiss를 해야 자연스러우니 제외한다.
//    func removeEndPageViewControllerFromStack(documentInfo: CTDocumentInfo) {
//        let lastViewController = viewControllers.last
//        viewControllers = viewControllers.filter({
//            if let endPageDocumentInfo = ($0 as? CTEndPageViewController)?.documentInfo {
//                // 삭제된 글의 엔드페이지인지 판단
//                return endPageDocumentInfo != documentInfo
//            } else {
//                // 현재 보고 있는 화면인지 판단
//                return $0 === lastViewController
//            }
//        })
//    }
    
    fileprivate func createViewControllerStackInfo() -> String {
        return viewControllers.compactMap({ $0.description }).enumerated().reduce("", { (previous, next: (offset: Int, element: String)) -> String in
            return previous + (next.offset == 0 ? "" : " // ") + next.element
        })
    }
}

class CTNavigationBar: UINavigationBar {
    
    private let customHeight: CGFloat = 67
    private var calculatedHeight: CGFloat {
        return 44 + ((customHeight - 44) / 2)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = calculatedHeight
        
        return size
    }
    
    // 버튼에만 터치이벤트가 먹히고 공백 영역은 터치이벤트를 무시해서 뒤에 깔려있는 view가 이벤트를 받도록 처리
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)

        return hitView == self ? nil : hitView
    }
}

protocol CTUnderlinedNavigationBarProtocol {
    var bottomBorderColor: UIColor? { get set }
}

class CTCustomNavigationBar: UIView {
    
    weak var viewController: UIViewController? {
        didSet {
            addDimmedUnderlineIfNeeded()
        }
    }
    var underlineView: UIView?
    
    private func addDimmedUnderlineIfNeeded() {
        guard underlineView?.superview != self else { return }
        guard viewController is CTUnderlinedNavigationBarProtocol else { return }
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = (viewController as? CTUnderlinedNavigationBarProtocol)?.bottomBorderColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        addSubview(view)
        addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 1.0))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[underline]|", options: [], metrics: nil, views: ["underline": view]))
        
        underlineView = view
        clipsToBounds = false
    }
}

//-----
class GPNavigationController: UINavigationController {
    
    override var description: String {
        return super.description + " // ViewControllers: " + createViewControllerStackInfo()
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let poppedViewControllers = super.popToRootViewController(animated: animated)
        
        updateStackInfoToNeloField()
        
        return poppedViewControllers
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        updateStackInfoToNeloField()
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let popped = super.popViewController(animated: animated)
        
        updateStackInfoToNeloField()
        
        return popped
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
    }
}

extension GPNavigationController {
    
    // Nelo에 viewController 스택 기록 추가
    fileprivate func updateStackInfoToNeloField() {
//        NeloLog.setCustomField(description, forKey: "ViewStack")
        
        if let viewController = viewControllers.last {
//            NeloLog.setCustomField(NSStringFromClass(viewController.classForCoder), forKey: "CurentViewController")
        }
    }
    
    // 삭제된 글의 엔드페이지를 스택에서 제거. 현재 화면인 경우에는 자체적으로 dismiss를 해야 자연스러우니 제외한다.
//    func removeEndPageViewControllerFromStack(documentInfo: GPDocumentInfo) {
//        let lastViewController = viewControllers.last
//        viewControllers = viewControllers.filter({
//            if let endPageDocumentInfo = ($0 as? GPEndPageViewController)?.documentInfo {
//                // 삭제된 글의 엔드페이지인지 판단
//                return endPageDocumentInfo != documentInfo
//            } else {
//                // 현재 보고 있는 화면인지 판단
//                return $0 === lastViewController
//            }
//        })
//    }
    
    fileprivate func createViewControllerStackInfo() -> String {
        return viewControllers.flatMap({ $0.description }).enumerated().reduce("", { (previous, next: (offset: Int, element: String)) -> String in
            return previous + (next.offset == 0 ? "" : " // ") + next.element
        })
    }
}

class GPNavigationBar: UINavigationBar {
    
    private let customHeight: CGFloat = 67
    private var calculatedHeight: CGFloat {
        return 44 + ((customHeight - 44) / 2)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = calculatedHeight
        
        return size
    }
    
    // 버튼에만 터치이벤트가 먹히고 공백 영역은 터치이벤트를 무시해서 뒤에 깔려있는 view가 이벤트를 받도록 처리
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        return hitView == self ? nil : hitView
    }
}

protocol GPUnderlinedNavigationBarProtocol {
    var bottomBorderColor: UIColor? { get set }
}

class GPCustomNavigationBar: UIView {
    
    weak var viewController: UIViewController? {
        didSet {
            addDimmedUnderlineIfNeeded()
        }
    }
    var underlineView: UIView?
    
    private func addDimmedUnderlineIfNeeded() {
        guard underlineView?.superview != self else { return }
        guard viewController is GPUnderlinedNavigationBarProtocol else { return }
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = (viewController as? GPUnderlinedNavigationBarProtocol)?.bottomBorderColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        addSubview(view)
        addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 1.0))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[underline]|", options: [], metrics: nil, views: ["underline": view]))
        
        underlineView = view
        clipsToBounds = false
    }
}

