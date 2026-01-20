//
//  FormConfig.swift
//  ShoppingList31
//
//  Created by Владимир on 15.01.2026.
//

import Foundation

struct FormConfig {
    let mode: ProductFormViewState
    let product: ShoppingItem?
    let list: ListItem?
    
    init(mode: ProductFormViewState, product: ShoppingItem? = nil, list: ListItem? = nil) {
        
        if mode == .editing && product == nil {
            fatalError("Для редактирования нужно передать продукт")
        }
        
        self.mode = mode
        self.product = product
        self.list = list
    }
}
