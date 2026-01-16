//
//  FormConfig.swift
//  ShoppingList31
//
//  Created by Владимир on 15.01.2026.
//

struct FormConfig {
    let mode: ProductFormViewState
    let product: ShoppingItem?
    
    init(mode: ProductFormViewState, product: ShoppingItem? = nil) {
        
        if mode == .editing && product == nil {
            fatalError("Для редактирования нужно передать продукт")
        }
        
        self.mode = mode
        self.product = product
    }
}
