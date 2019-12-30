//
//  GPEasyButton.swift
//  GP
//
//  Created by Cho SeongHyun on 2017. 4. 13..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import UIKit

class GPEasyButton: UIButton {
    
    typealias TouchedClosure = () -> Void
    var touchedClosure: TouchedClosure?
    var touchType: UIControl.Event {
        // 스크랩버튼은 touchDown이 어울리고, 그 외 버튼은 touchUpInside가 어울릴 것 같음
        return .touchUpInside
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeTouchedClosure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initializeTouchedClosure()
    }
    
    func initializeTouchedClosure() {
        addTarget(self, action: #selector(excuteTouchedClosure), for: touchType)
    }
    
    @objc func excuteTouchedClosure() {
        touchedClosure?()
    }
}

// 버튼의 image-title의 간격을 inset으로 벌려주면 버튼의 크기가 자동으로 늘어나지 않아 title이 짤리는 현상이 발생.
// 해결방안 - intrinsicContentSize를 override. http://stackoverflow.com/questions/4564621/aligning-text-and-image-on-uibutton-with-imageedgeinsets-and-titleedgeinsets
class GPIconAndTitleButton: GPEasyButton {
    
    override var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        
        let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
        let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
        
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
}
