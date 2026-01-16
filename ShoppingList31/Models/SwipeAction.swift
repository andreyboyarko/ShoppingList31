//
//  SwipeAction.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/15/26.
//
import Foundation
import SwiftUI

struct SwipeAction: Identifiable {
    let id = UUID()
    let systemImage: String
    let tint: Color
    let handler: () -> Void
}
