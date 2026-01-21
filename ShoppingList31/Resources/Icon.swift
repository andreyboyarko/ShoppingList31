//
//  Icon.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 06.01.2026.
//

import SwiftUI

enum Icon: String, CaseIterable, Identifiable, Codable {
    case snow, airplane, alert,
         balloon, bandage, barbell,
         bed, briefcase, build,
         business, calendarNumber, gift,
         colorPalette, cart, car,
         fastFood, paw, gameController
    
    var id: String { rawValue }
    
    var icon: ImageResource {
        switch self {
        case .snow: .snow
        case .airplane: .airplane
        case .alert: .alert
        case .balloon: .balloon
        case .bandage: .bandage
        case .barbell: .barbell
        case .bed: .bed
        case .briefcase: .briefcase
        case .build: .build
        case .business: .business
        case .calendarNumber: .calendarNumber
        case .gift: .gift
        case .colorPalette: .colorPalette
        case .cart: .cart
        case .car: .car
        case .fastFood: .fastFood
        case .paw: .paw
        case .gameController: .gameController
        }
    }
}
