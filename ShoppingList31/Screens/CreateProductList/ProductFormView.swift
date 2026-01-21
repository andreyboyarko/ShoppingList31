//
//  ProductFormView.swift
//  ShoppingList31
//
//  Created by Владимир on 08.01.2026.
//

import SwiftUI
import SwiftData

struct ProductFormView: View {
    let config: FormConfig
    @State private var observed: ProductFormObserved
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init (config: FormConfig) {
        self.config = config
        self._observed = State(initialValue: ProductFormObserved(config: config))
    }
    
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                navigationHeader
                productNameField
                    .onChange(of: observed.productName, { _, newValue in
                        observed.findSuggestions(for: newValue)
                    })
                    .padding(.top, 20)
                
                if observed.isSuggestionsVisible {
                    suggestionMenu
                        .padding(.top, 10)
                }
                
                HStack(spacing: 16) {
                    quantityField
                    unitSelectionField
                }
                .padding(.top, 20)
                .opacity(observed.isSuggestionsVisible ? 0 : 1)
                
                if observed.isMenuShowing { UnitSelectionMenu(needShowMenu: $observed.isMenuShowing,
                                                              selectedUnit: $observed.selectedUnit,
                                                              pikerUnitName: $observed.unitPickerSelection)}
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 21)
        }
    }
    
    private var navigationHeader: some View {
        HStack {
            cancelButton
            Spacer()
            titleView
            Spacer()
            submitButton
        }
    }
    
    private var cancelButton: some View {
        Button("Отменить") {
            dismiss()
        }
        .font(.body)
        .foregroundStyle(.textHint)
    }
    
    private var titleView: some View {
        Text(observed.navigationTitle)
            .font(.navigationBarButton)
            .foregroundStyle(.textSecondary)
    }
    
    private var submitButton: some View {
        Button("Готово") {
            
            if observed.isCreating {
                guard let count = Int(observed.productCount),
                      let list = config.list
                else { return }
                
                
                let item = ShoppingItem(
                    name: observed.productName,
                    count: count,
                    unit: observed.selectedUnit,
                    list: list)
                
                context.insert(item)
                
                config.list?.total += 1
            } else {
                guard let count = Int(observed.productCount) else { return }
                
                config.product?.name = observed.productName
                config.product?.count = count
                config.product?.unit = observed.selectedUnit
            }
            
            if observed.isCreating {
                observed.cleanField()
            }
            dismiss()
        }
        .font(.navigationBarButton)
        .foregroundStyle(observed.isFormValid ? .turquoise : .textHint)
        .disabled(!observed.isFormValid)
    }
    
    private var productNameField: some View {
        observed.isCreating ?
        NameTextField(placeholder: "Название товара", text: $observed.productName) :
        NameTextField(placeholder: "", text: $observed.productName)
    }
    
    private var suggestionMenu: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(observed.suggestedProductsArray, id: \.self) { word in
                    Button {
                        observed.setNewProduct(name: word)
                    } label: {
                        HStack(spacing: 0) {
                            Text(word)
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.vertical, 11)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        .background(.surfaceBackground)
                    }
                    
                    Divider()
                        .padding(.horizontal, 16)
                        .background(.surfaceBackground)
                }
            }
            .cornerRadius(12)
        }
    }
    
    private var quantityField: some View {
        observed.isCreating ?
        NameTextField(placeholder: "Количество", text: $observed.productCount).keyboardType(.phonePad) :
        NameTextField(placeholder: "", text: $observed.productCount).keyboardType(.phonePad)
    }
    
    private var unitSelectionField: some View {
        NameTextField(
            placeholder: observed.isCreating  ? "Ед.Изм.:" : "",
            text: $observed.selectedUnit
        )
        .disabled(true)
        .overlay(
            customPicker
        )
        .onTapGesture {
            observed.showMenu()
        }
    }
    
    private var customPicker: some View {
        HStack {
            Spacer()
            Text(observed.unitPickerSelection.rawValue)
            Image(systemName: "chevron.up.chevron.down")
        }
        .font(.body)
        .foregroundStyle(.turquoise)
        .padding(.trailing, 16)
        .opacity(observed.isPikerShowing ? 1 : 0)
    }
}

extension ProductFormView {
    @Observable
    final class ProductFormObserved {
        
        var productName: String = ""
        var productCount: String = ""
        var selectedUnit: String = ""
        var unitPickerSelection: UnitsProduct = .pieces
        var isMenuShowing: Bool = false
        
        private let suggestionService: ProductSuggestionProtocol
        var suggestedProductsArray: [String] = []
        var isSuggestionsVisible: Bool {
            let hasInput = !productName.isEmpty
            let hasSuggestions = !suggestedProductsArray.isEmpty
            let isExactMatch =  suggestedProductsArray.first != productName
            
            return hasInput && hasSuggestions && isExactMatch
        }
        
        private let isEditing: Bool
        
        var isFormValid: Bool {
            guard !productName.isEmpty,
                  !productCount.isEmpty,
                  !selectedUnit.isEmpty,
                  let count = Int(productCount), count > 0 else {
                return false
            }
            return true
        }
        
        var isPikerShowing: Bool {
            selectedUnit.isEmpty || isMenuShowing
        }
        
        var isCreating: Bool { !isEditing }
        
        var navigationTitle: String {
            isCreating ? "Создание товара" : "Редактирование"
        }
        
        init(config: FormConfig, suggestionService: ProductSuggestionProtocol = ProductSuggestionService()) {
            self.isEditing = config.product != nil
            self.suggestionService = suggestionService
            
            if let product = config.product {
                self.productName = product.name
                self.productCount = String(product.count)
                self.selectedUnit = product.unit
                self.unitPickerSelection = UnitsProduct(rawValue: product.unit) ?? UnitsProduct.pieces
            }
        }
        
        func cleanField() {
            selectedUnit = ""
            productCount = ""
            productName = ""
            unitPickerSelection = .pieces
            isMenuShowing = false
            suggestedProductsArray = []
        }
        
        func showMenu() {
            isMenuShowing = true
        }
        
        func findSuggestions(for searchText: String) {
            suggestedProductsArray = suggestionService.findSuggestion(in: searchText)
        }
        
        func setNewProduct(name: String) {
            productName = name
            suggestedProductsArray = []
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        
        @State private var formConfig: FormConfig?
        
        let item = ListItem(color: .blue, icon: .airplane, title: "", completed: 0, total: 0)
        
        var body: some View {
            NavigationStack {
                VStack(spacing: 20) {
                    Button("Создать новый товар") {
                        formConfig = FormConfig(list: item)
                    }
                    Button("Редактировать молоко") {
                        formConfig = FormConfig(product: ShoppingItem(name: "Молоко", count: 2, unit: UnitsProduct.liter.rawValue, list: item))
                    }
                }
            }
            .sheet(item: $formConfig) { config in
                ProductFormView(config: config)
            }
        }
    }
    return PreviewWrapper()
}
