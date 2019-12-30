//
//  GPCircleImageView.swift
//  GP
//
//  Created by 이인재 on 23/05/2017.
//  Copyright © 2017 NAVER Corp. All rights reserved.
//

import UIKit

class GPCircleImageView: UIImageView {

	private var fillLayer: CAShapeLayer!
	private let lineLayer = CAShapeLayer()
	
	override func layoutSublayers(of layer: CALayer) {
		super.layoutSublayers(of: layer)

		if fillLayer == nil {
			fillLayer = CAShapeLayer()
			fillLayer?.fillColor = UIColor.black.cgColor
			layer.mask = fillLayer
			
			lineLayer.lineWidth = 1
            lineLayer.strokeColor = UIColor(white: 0, alpha: 0.15).cgColor
			lineLayer.fillColor = UIColor.clear.cgColor
			
			layer.addSublayer(lineLayer)
		}
		
		updateUI()
	}
	
	private func updateUI() {
		let radius = bounds.width / 2.0
		let path = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
		
		fillLayer?.frame = bounds
		fillLayer?.path = path.cgPath
		
		lineLayer.path = path.cgPath
	}
}
