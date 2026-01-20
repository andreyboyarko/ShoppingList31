//
//  UnitsProduct.swift
//  ShoppingList31
//
//  Created by Владимир on 14.01.2026.
//

import SwiftUI

enum UnitsProduct: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case pieces = "шт"
    case kilogram = "кг"
    case gram = "г"
    case liter = "л"
    case milliliter = "мл"
    
    var localizedName: String {
        String(localized: String.LocalizationValue(rawValue))
    }
}
