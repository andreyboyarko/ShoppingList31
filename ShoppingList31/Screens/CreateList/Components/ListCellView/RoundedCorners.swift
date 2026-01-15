//
//  RoundedCorners.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/15/26.
//
import SwiftUI

struct RoundedCorners: InsettableShape {
    var radius: CGFloat = 16
    var corners: UIRectCorner = .allCorners
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)

        let path = UIBezierPath(
            roundedRect: insetRect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.insetAmount += amount
        return copy
    }
}
