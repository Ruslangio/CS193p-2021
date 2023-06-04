//
//  Squiggle.swift
//  Set
//
//  Created by Ruslan Alekyan on 18.04.2023.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let xOffset = rect.width * 0.1
        let yOffset = rect.height * 0.2
        
        var point = Path()
        
        point.move(to: start)
        point.addCurve(to: CGPoint(x: rect.midX, y: rect.height / 8),
                       control1: CGPoint(x: rect.minX, y: rect.minY),
                       control2: CGPoint(x: rect.midX - xOffset, y: rect.height / 8 - yOffset))
        point.addCurve(to: CGPoint(x: rect.width * 0.8, y: rect.height / 8),
                       control1: CGPoint(x: rect.midX + xOffset, y: rect.height / 8 + yOffset),
                       control2: CGPoint(x: rect.width * 0.8 - xOffset, y: rect.height / 8 + yOffset))
        point.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                       control1: CGPoint(x: rect.width * 0.8 + xOffset, y: rect.height / 8 - yOffset),
                       control2: CGPoint(x: rect.maxX, y: rect.minY))
                
        var reversePoint = point
        
        reversePoint = reversePoint.applying(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        reversePoint = reversePoint.applying(CGAffineTransform.identity.translatedBy(x: rect.width, y: rect.height))
        point.move(to: start)
        point.addPath(reversePoint)
        
        return point
    }
}
