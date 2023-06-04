//
//  Diamond.swift
//  Set
//
//  Created by Ruslan Alekyan on 17.04.2023.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        
        var point = Path()
        point.move(to: top)
        point.addLine(to: left)
        point.addLine(to: bottom)
        point.addLine(to: right)
        point.addLine(to: top)
        
        return point
    }
}
