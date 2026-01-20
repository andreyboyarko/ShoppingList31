//
//  ProductFormView.swift
//  ShoppingList31
//
//  Created by Владимир on 08.01.2026.
//

import SwiftUI

struct ProductFormView: View {
    
    let config: FormConfig
    @State private var observed: ProductFormObserved
    @Environment(\.dismiss) private var dismiss
    
    init(config: FormConfig) {
        self.config = config
        self._observed = State(initialValue: ProductFormObserved(config: config))
    }
    
    var body: some View {
        ZStack {
            Color(.appBackground)
            VStack(spacing: 20) {
                navigationHeader
                productNameField
                HStack(spacing: 16) {
                    quantityField
                    unitSelectionField
                }
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
            observed.saveToDatabase()
            dismiss()
        }
        .font(.navigationBarButton)
        .foregroundStyle(observed.isFormValid ? .turquoise : .textHint)
        .disabled(!observed.isFormValid)
    }
    
    private var productNameField: some View {
        observed.isCreating ? NameTextField(placeholder: "Название товара", text: $observed.productName) : NameTextField(placeholder: "", text: $observed.productName)
    }
    
    private var quantityField: some View {
        observed.isCreating ? NameTextField(placeholder: "Количество", text: $observed.productCount).keyboardType(.phonePad) : NameTextField(placeholder: "", text: $observed.productCount).keyboardType(.phonePad)
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
        
        private var mode: ProductFormViewState
        var isMenuShowing: Bool = false
        
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
        
        var isCreating: Bool {
            mode == .creating
        }
        
        var navigationTitle: String {
            isCreating ? "Создание товара" : "Редактирование товара"
        }
        
        init(config: FormConfig) {
            
            self.mode = config.mode
            
            if let product = config.product {
                self.productName = product.name
                self.productCount = String(product.count)
                self.selectedUnit = product.unit
                self.unitPickerSelection = UnitsProduct(rawValue: product.unit) ?? UnitsProduct.pieces
            }
        }
        
        func saveToDatabase() {
            guard isFormValid  else { return }
            
            // Сохранить в SwiftData
            if isCreating {
                print("[ProductFormObserved/saveToDatabase] Сохранение в БД:")
                print("  Название: \(productName)")
                print("  Количество: \(productCount)")
                print("  Единица: \(selectedUnit)")
                print("  Режим: \(mode)")
            } else {
                print("[ProductFormObserved/saveToDatabase] Изменения в БД:")
                print("  Новое Название: \(productName)")
                print("  Новое Количество: \(productCount)")
                print("  Новая Единица: \(selectedUnit)")
                print("  Режим: \(mode)")
            }
            
            if isCreating {
                cleanField()
            }
        }
        
        func cleanField() {
            selectedUnit = ""
            productCount = ""
            productName = ""
            unitPickerSelection = .pieces
            isMenuShowing = false
        }
        
        func showMenu() {
            isMenuShowing = true
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        
        @State private var showingSheet = true
        
        var body: some View {
            ZStack {
                Color.orange
                    .ignoresSafeArea()
                Button("Показать форму") {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                ProductFormView(isPresented: $showingSheet, config: FormConfig(mode: .creating))
            }
        }
    }
    return PreviewWrapper()
}

#Preview {
    struct PreviewWrapper: View {
        
        @State private var showingSheet = true
        
        var body: some View {
            ZStack {
                Color.orange
                    .ignoresSafeArea()
                Button("Показать форму") {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                ProductFormView(isPresented: $showingSheet, config: FormConfig(mode: .editing, product: ShoppingItem(name: "Молоко", count: 2, unit: UnitsProduct.liter.rawValue)))
            }
        }
    }
    return PreviewWrapper()
}
