//
//  SlantedRectangle.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-23.
//

import SwiftUI

struct SlantedRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let lowerRightCorner: CGFloat = rect.maxY * 0.2 // Adjust this value to control the slant of the right side

        // Start from the top left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        // Add line to the top right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        // Add line to the bottom right corner (slanted)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - lowerRightCorner))
        // Add line to the bottom left corner
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        // Close the path to connect to the starting point
        path.closeSubpath()

        return path
    }
}

#Preview {
    SlantedRectangle()
}
