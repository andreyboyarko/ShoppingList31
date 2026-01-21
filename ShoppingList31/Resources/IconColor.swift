//
//  IconColor.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 29.12.2025.
//

import SwiftUI

enum IconColor: String, CaseIterable, Identifiable, Codable {
    case green, purple, blue, red, yellow
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .green: .iconGreen
        case .purple: .iconPurple
        case .blue: .iconBlue
        case .red: .iconRed
        case .yellow: .iconYellow
        }
    }
}
