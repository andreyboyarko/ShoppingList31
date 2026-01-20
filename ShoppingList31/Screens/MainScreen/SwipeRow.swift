//
//  SwipeRow.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/15/26.
//
import SwiftUI

struct SwipeRow<Content: View>: View {
    let height: CGFloat
    let cornerRadius: CGFloat
    let buttonWidth: CGFloat
    let actions: [SwipeAction]
    let content: Content

    @State private var offsetX: CGFloat = 0
    @State private var isOpen: Bool = false

    private var maxReveal: CGFloat {
        CGFloat(actions.count) * buttonWidth
    }

    init(
        height: CGFloat = 84,
        cornerRadius: CGFloat = 16,
        buttonWidth: CGFloat = 62,
        actions: [SwipeAction],
        @ViewBuilder content: () -> Content
    ) {
        self.height = height
        self.cornerRadius = cornerRadius
        self.buttonWidth = buttonWidth
        self.actions = actions
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .trailing) {

            // MARK: - Swipe actions (background)
            HStack(spacing: 0) {
                ForEach(actions) { action in
                    Button {
                        action.handler()
                        close()
                    } label: {
                        Image(systemName: action.systemImage)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: buttonWidth, height: height)
                            .background(action.tint)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(width: maxReveal, height: height)
            .frame(maxWidth: .infinity, alignment: .trailing)

            // MARK: - Content
            content
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .offset(x: offsetX)
                .contentShape(Rectangle())
                .allowsHitTesting(!isOpen)
                .animation(
                    .interactiveSpring(response: 0.25, dampingFraction: 0.9),
                    value: offsetX
                )
        }
        .background(Color.surfaceBackground)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .frame(height: height)
        .onTapGesture {
            if isOpen {
                close()
            }
        }
        .simultaneousGesture(dragGesture)
    }

    // MARK: - Gesture
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                if abs(value.translation.height) > abs(value.translation.width) + 30 {
                    return
                }

                let baseOffset = isOpen ? -maxReveal : 0
                let proposed = baseOffset + value.translation.width

                offsetX = clamp(proposed, min: -maxReveal, max: 0)
            }
            .onEnded { value in
                if abs(value.translation.height) > abs(value.translation.width) + 30 {
                    close()
                    return
                }

                let shouldOpen =
                    (-offsetX > maxReveal * 0.35) ||
                    value.predictedEndTranslation.width < -40

                if shouldOpen {
                    open()
                } else {
                    close()
                }
            }
    }

    // MARK: - Helpers
    private func open() {
        offsetX = -maxReveal
        isOpen = true
    }

    private func close() {
        offsetX = 0
        isOpen = false
    }

    private func clamp(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        Swift.max(min, Swift.min(max, value))
    }
}
