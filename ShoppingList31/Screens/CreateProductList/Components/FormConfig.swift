//
//  FormConfig.swift
//  ShoppingList31
//
//  Created by Владимир on 15.01.2026.
//

import Foundation

struct FormConfig: Identifiable {
    
    let id = UUID()
    let product: ShoppingItem?
    let list: ListItem?
    
    init(list: ListItem) {
        self.product = nil
        self.list = list
    }
    
    init(product: ShoppingItem) {
        self.product = product
        self.list = nil
    }
}
