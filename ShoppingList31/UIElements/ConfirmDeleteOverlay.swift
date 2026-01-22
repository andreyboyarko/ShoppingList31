//
//  ConfirmDeleteOverlay.swift
//  ShoppingList31
//
//  Created by Sultan Akhmetbek on 22.01.2026.
//

import SwiftUI

struct ConfirmDeleteOverlay: View {
    let title: String
    let message: String
    let cancelTitle: String
    let confirmTitle: String
    let onCancel: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onCancel()
                }

            VStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Text(message)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)

                HStack(spacing: 12) {
                    Button {
                        onCancel()
                    } label: {
                        Text(cancelTitle)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.turquoise)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.turquoise, lineWidth: 1)
                            )
                    }

                    Button {
                        onConfirm()
                    } label: {
                        Text(confirmTitle)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.swipeActionIRed)
                            )
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
            )
            .padding(.horizontal, 50)
        }
        .transition(.opacity.combined(with: .scale))
        .animation(.easeInOut(duration: 0.2), value: UUID())
    }
}


#Preview {
    ConfirmDeleteOverlay(
        title: "Удаление купленных товаров",
        message: "Вы действительно хотите удалить все купленные товары?",
        cancelTitle: "Отмена",
        confirmTitle: "Удалить",
        onCancel: {},
        onConfirm: {}
    )
}
