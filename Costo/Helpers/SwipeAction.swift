//
//  SwipeAction.swift
//  Costo
//
//  Created by Ivan Morgun on 23.03.2024.
//

import SwiftUI

struct Action: Identifiable {
    private(set) var id: UUID = .init()
    var tint: Color
    var icon: String
    var iconFont: Font = .title
    var iconTint: Color = .white
    var isEnabled: Bool = true
    var action: () -> ()
}

struct SwipeAction<Content: View>: View {
    var cornerRadius: CGFloat  = 0
    var direction: SwipeDirection = .trailing
    let viewId = UUID()
    
    @ViewBuilder var content: Content
    @ActionBuilder var actions: [Action]
    @State private var isEnbled: Bool = true
    @State private var scrollOffset: CGFloat = .zero
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    content
                        .rotationEffect(.init(degrees: direction == .leading ? -180 : 0))
                        .containerRelativeFrame(.horizontal)
                        .background(scheme == .dark ? .black : .white)
                        .background {
                            if let firstAction = filteredActions.first {
                                Rectangle()
                                    .fill(firstAction.tint)
                                    .opacity(scrollOffset == .zero ? 0 : 1)
                            }
                        }
                        .id(viewId)
                        .transition(.identity)
                        .overlay {
                            GeometryReader {
                                let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                                Color.clear
                                    .preference(key: OffsetKey.self, value: minX)
                                    .onPreferenceChange(OffsetKey.self) {
                                        scrollOffset = $0
                                    }
                            }
                        }
                    
                    ActionButtons {
                        withAnimation(.snappy) {
                            proxy.scrollTo(viewId, anchor: direction == .trailing ? .topLeading : .topTrailing)
                        }
                    }
                    .opacity(scrollOffset == .zero ? 0 : 1)
                }
                
                .scrollTargetLayout()
                .visualEffect { content, gp in
                    content
                        .offset(x: scrollOffset(gp))
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned) // iOS 17 only
            .background {
                if let lastAction = filteredActions.last {
                    Rectangle()
                        .fill(lastAction.tint)
                        .opacity(scrollOffset == .zero ? 0 : 1)
                }
            }
            .clipShape(.rect(cornerRadius: cornerRadius))
            .rotationEffect(.init(degrees: direction == .leading ? 180 : 0))
        }
        .allowsHitTesting(isEnbled)
        .transition(CustomTransaction())
    }
    
    @ViewBuilder
    func ActionButtons(resetPosition: @escaping () -> ()) -> some View {
        Rectangle()
            .fill(.clear)
            .frame(width: CGFloat(filteredActions.count) * 100)
            .overlay(alignment: direction.alignment) {
                HStack(spacing: 0) {
                    ForEach(filteredActions) { button in
                        Button(action: {
                            Task {
                                isEnbled = false
                                resetPosition()
                                try? await Task.sleep(for: .seconds(0.25))
                                button.action()
                                try? await Task.sleep(for: .seconds(0.1))
                                isEnbled = true
                            }
                        }, label: {
                            Image(systemName: button.icon)
                                .font(button.iconFont)
                                .foregroundStyle(button.iconTint)
                                .frame(width: 100)
                                .frame(maxHeight: .infinity)
                                .contentShape(.rect)
                        })
                        .buttonStyle(.plain)
                        .background(button.tint)
                        .rotationEffect(.init(degrees: direction == .leading ? -180 : 0))
                    }
                }
            }
    }
    
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX > 0 ? -minX : 0
    }
    
    var filteredActions: [Action] {
        return actions.filter({ $0.isEnabled })
    }
}

@resultBuilder
struct ActionBuilder {
    static func buildBlock(_ components: Action...) -> [Action] {
        return components
    }
}

struct CustomTransaction: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content.mask {
            GeometryReader {
                let size = $0.size
                Rectangle()
                    .offset(y: phase == .identity ? 0 : -size.height)
            }
            .containerRelativeFrame(.horizontal)
        }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

enum SwipeDirection {
    case leading, trailing
    
    var alignment: Alignment {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}
