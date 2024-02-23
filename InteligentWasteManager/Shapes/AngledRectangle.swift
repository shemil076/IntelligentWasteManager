//
//  AngledRectangle.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-23.
//

import SwiftUI

struct AngledRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let angleOffset: CGFloat = 30 // Change this value to adjust the angle

        path.move(to: CGPoint(x: rect.minX, y: rect.minY)) // Top-left
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // Top-right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - angleOffset)) // Bottom-right, with offset
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Bottom-left
        path.closeSubpath()

        return path
    }
}

#Preview {
    AngledRectangle()
}
