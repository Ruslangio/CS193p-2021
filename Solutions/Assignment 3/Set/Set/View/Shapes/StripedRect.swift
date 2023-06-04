//
//  StripedRect.swift
//  Set
//
//  Created by Ruslan Alekyan on 21.04.2023.
//

import SwiftUI

struct StripedRect: Shape {
    func path(in rect: CGRect) -> Path {
        var xOffset = 0.0
        var point = Path()
        
        while xOffset < rect.maxX {
            point.move(to: CGPoint(x: xOffset, y: rect.minY))
            point.addLine(to: CGPoint(x: xOffset, y: rect.maxY))
            xOffset += 2
        }
        
        return point
    }
}

extension Shape {
    func striped() -> some View {
        ZStack {
            StripedRect().stroke().clipShape(self)
            self.stroke()
        }
    }
}
