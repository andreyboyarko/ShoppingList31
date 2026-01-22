//
//  WelcomeView.swift
//  ShoppingList31
//
//  Created by Stepan Chuiko on 10.01.2026.
//

import SwiftUI

struct WelcomeView: View {
    let onStart: () -> Void
    
    var body: some View {
        ZStack {
            background
            
            VStack(spacing: 48) {
                welcomeText
                image
                descriptionText
                
                Spacer()
                
                ActionButton(
                    title: Phrases.start,
                    isActive: true,
                    action: onStart
                )
            }
            .padding(.top, 40)
        }
    }
    
    private var welcomeText: some View {
        Text(Phrases.welcome)
            .font(.largeTitle)
            .foregroundStyle(.textPrimary)
    }
    
    private var image: some View {
        Image(.amico)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 49)
    }
    
    private var descriptionText: some View {
        VStack(spacing: 12) {
            Text(Phrases.message1)
                .font(.mediumTitle)
            Text(Phrases.message2)
                .font(.body)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
        .foregroundStyle(.textSecondary)
    }
    
    private var background: some View {
        Color.appBackground
            .ignoresSafeArea()
    }
    
    enum Phrases {
        static let welcome = String(localized: "Добро пожаловать!")
        static let message1 = String(localized: "Никогда не забывайте, что нужно купить")
        static let message2 = String(localized: "Создавайте списки и не переживайте о покупках")
        static let start = String(localized: "Начать")
    }
}

#Preview {
    WelcomeView {
        print("Pushed button Начать")
    }
}
