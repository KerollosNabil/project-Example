//
//  RoundedSideView.swift
//  tryPhatmacy
//
//  Created by MAC on 6/2/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class RoundedSideView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .bottomRight, cornerRadii: CGSize(width: cornerRedus, height: cornerRedus))
        path.addClip()
        UIColor.red.setFill()
        path.fill()
    }

}
extension RoundedSideView {
    private struct sizeRatio {
        static let cornreFontSizeToBoundHight:CGFloat = 0.085
        static let cornerRedusToToBoundHight:CGFloat = 0.06
        static let cornerOffsetToCornerRedius:CGFloat = 0.33
        static let faceCardImageToboundSize:CGFloat = 0.65
        static let pipsOffsetRatio:CGFloat = 1.8
    }
    
    private var cornerRedus:CGFloat{
        return bounds.size.height * sizeRatio.cornerRedusToToBoundHight
    }
    private var cornerFontSize:CGFloat {
        return bounds.size.height * sizeRatio.cornreFontSizeToBoundHight
    }
    private var cornerOffset:CGFloat {
        return cornerRedus * sizeRatio.cornerOffsetToCornerRedius
    }
    
    
}
extension CGRect {
    var leftHafe : CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHafe : CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func  inset(py size:CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size:CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(py ratio:CGFloat) -> CGRect {
        return insetBy(dx: (width-(width*ratio))/2, dy: (height-(height*ratio))/2)
    }
}
extension CGPoint {
    func  offsetBy(dx:CGFloat, dy:CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
