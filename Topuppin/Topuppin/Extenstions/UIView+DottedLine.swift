//
//  UIView+DottedLine.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

extension UIView {
    func makeDashedBorderLine(color: UIColor,
                              strokeLength: NSNumber,
                              gapLength: NSNumber,
                              width: CGFloat) {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineDashPattern = [strokeLength, gapLength]

        path.addLines(between: [CGPoint(x: 0, y: bounds.midY),
                                CGPoint(x: self.bounds.width, y: bounds.midY)])

        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
