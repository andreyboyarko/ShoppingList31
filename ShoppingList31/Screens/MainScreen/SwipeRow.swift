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
    
    private var maxReveal: CGFloat { CGFloat(actions.count) * buttonWidth }
    
    private var contentShape: some Shape {
        if offsetX == 0 {
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            return AnyShape(RoundedCorners(radius: cornerRadius, corners: [.topLeft, .bottomLeft]))
        }
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
            HStack(spacing: 0) {
                ForEach(Array(actions.enumerated()), id: \.element.id) { idx, action in
                    Button {
                        action.handler()
                        close()
                    } label: {
                        Image(systemName: action.systemImage)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: buttonWidth, height: height)
                            .background(actionBackground(for: idx, color: action.tint))
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(height: height)
            
            content
                .frame(height: height)
                .offset(x: offsetX)
                .clipShape(contentShape)
                .contentShape(Rectangle())
                .simultaneousGesture(dragGesture)
                .animation(.interactiveSpring(response: 0.25, dampingFraction: 0.9), value: offsetX)
        }
        .clipped()
    }
    
    private func actionBackground(for idx: Int, color: Color) -> some View {
        Group {
            if idx == actions.count - 1 {
                color
                    .clipShape(RoundedCorners(radius: cornerRadius, corners: [.topRight, .bottomRight]))
            } else {
                color
            }
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 8)
            .onChanged { value in
                if abs(value.translation.height) > abs(value.translation.width) + 10 {
                    return
                }
                
                let proposed = (isOpen ? -maxReveal : 0) + value.translation.width
                
                if proposed > 0 {
                    offsetX = 0
                    return
                }
                
                offsetX = clamp(proposed, min: -maxReveal, max: 0)
            }
            .onEnded { value in
                if abs(value.translation.height) > abs(value.translation.width) + 10 {
                    close()
                    return
                }
                
                let shouldOpen = (-offsetX) > (maxReveal * 0.35) || value.predictedEndTranslation.width < -40
                if shouldOpen {
                    open()
                } else {
                    close()
                }
            }
    }
    
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
