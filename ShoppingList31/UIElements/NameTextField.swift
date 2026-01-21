//
//  NameTextField.swift
//  ShoppingList31
//
//  Created by Stepan Chuiko on 03.01.2026.
//

import SwiftUI

/// TextField с функцией отображения ошибки ввода названия
/// - Parameter placeholder: Текст-подсказка
/// - Parameter text: @State поле для вводимого текста (через $)
/// - Parameter state: @State поле для управления состоянием
struct NameTextField: View {
    
    enum TextFieldState: Equatable {
        case normal
        case error(message: String)
    }
    
    let placeholder: String
    @Binding var text: String
    var state: TextFieldState = .normal
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.surfaceBackground)
                    .stroke(borderColor, lineWidth: 0.5)
                
                HStack(spacing: 8) {
                    TextField(placeholder, text: $text)
                        .font(.body)
                        .foregroundStyle(.textSecondary)
                        .focused($isFocused)
                        .padding(.leading, 16)
                        .padding(.trailing, text.isEmpty ? 16 : 0)
                        .frame(height: 54)
                    
                    if !text.isEmpty && isFocused {
                        Button {
                            text = ""
                            isFocused = true
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.gray)
                                .padding(.trailing, 12)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(height: 54)
            
            if case .error(let message) = state {
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .padding(.horizontal, 8)
            }
        }
    }
    
    private var borderColor: Color {
        switch state {
        case .normal: .clear
        case .error: .red
        }
    }
}

#Preview("Normal") {
    VStack(spacing: 16) {
        Spacer()
        NameTextField(placeholder: "Введите название списка", text: .constant(""))
        Spacer()
    }
    .padding()
    .background(Color("AppBackground"))
}

#Preview("Error") {
    VStack {
        NameTextField(
            placeholder: "Введите название списка",
            text: .constant("Новый год"),
            state: .error(message: "Это название уже используется, пожалуйста, измените его.")
        )
        Spacer()
    }
    .padding()
    .background(Color("AppBackground"))
}
