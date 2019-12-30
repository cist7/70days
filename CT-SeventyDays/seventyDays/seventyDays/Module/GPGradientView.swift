//
//  GPGradientView.swift
//  GP
//
//  그라데이션 딤드 처리 뷰
//
//  Created by Nakyung Lim on 2017. 4. 12..
//  Copyright © 2017년 NAVER Corp. All rights reserved.
//

import UIKit

class GPGradientView: UIView {
    
    let gradientDimmedLayer = CAGradientLayer()
    var gradientColors: [CGColor] = [] {
        didSet { gradientDimmedLayer.colors = gradientColors }
    }
    var gradientOpacity: Float = 1.0 {
        didSet { gradientDimmedLayer.opacity = gradientOpacity }
    }
    var updateGradientFrameClosure: ((CALayer) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initializeGradientDimmedLayer()
        layer.insertSublayer(gradientDimmedLayer, at: 0)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeGradientDimmedLayer()
        layer.insertSublayer(gradientDimmedLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateGradientDimmedLayersFrame()
    }
    
    // Gradient layer의 색상과 투명도 등의 값을 설정한다.
    private func initializeGradientDimmedLayer() {
        gradientDimmedLayer.colors = gradientColors
        gradientDimmedLayer.opacity = gradientOpacity
    }
    
    // Gradient layer의 frame을 설정한다.
    private func updateGradientDimmedLayersFrame() {
        updateGradientFrameClosure?(gradientDimmedLayer)
    }
}
