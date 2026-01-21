//
//  ProductSuggestionService.swift
//  ShoppingList31
//
//  Created by Владимир on 19.01.2026.
//

import Foundation

protocol ProductSuggestionProtocol {
    func findSuggestion(in element: String) -> [String]
}

final class ProductSuggestionService: ProductSuggestionProtocol {
    private var allProductsArray: [String] = []
    
    func findSuggestion(in element: String) -> [String] {
        let filteredArray = allProductsArray.filter {$0.lowercased().hasPrefix(element.lowercased())}
        return filteredArray
    }
    
    init() {
        self.allProductsArray = loadProduct()
    }
    
    private func loadProduct() -> [String] {
        guard let url = Bundle.main.url(forResource: "Products", withExtension: "json") else {
            print("[ProductSuggestionService]: файл не загруежн")
            return []
        }
        
        do {
            let actualData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let actualArray = try decoder.decode([String].self, from: actualData)
            
            return actualArray
        } catch {
            print("[ProductSuggestionService]: ошибка при декодировании")
        }
        
        return []
    }
}
