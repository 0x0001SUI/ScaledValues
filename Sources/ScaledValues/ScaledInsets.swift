//
//  ScaledInsets.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//

import SwiftUI


// MARK: - ScaledInsets

/// A dynamic property that scales the inset distances based on the current Dynamic Type settings.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@propertyWrapper public struct ScaledInsets: DynamicProperty {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @State private var value: EdgeInsets
    
    private let minimumValue: EdgeInsets?
    private let maximumValue: EdgeInsets?
    private let textStyle: Font.TextStyle

    // MARK: Initializer
    
    /// Creates the scaled inset distances using unscaled inset distances bounded by minimum and maximum values, and a text style to scale relative to.
    public init(
        wrappedValue defaultValue: EdgeInsets,
        min minimumValue: EdgeInsets? = nil,
        max maximumValue: EdgeInsets? = nil,
        relativeTo textStyle: Font.TextStyle = .body)
    {
        self.textStyle = textStyle
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self._value = State(wrappedValue: defaultValue)
    }
    
    private var top: CGFloat {
        value.top
    }
    
    private var bottom: CGFloat {
        value.bottom
    }
    
    private var leading: CGFloat {
        value.leading
    }
    
    private var trailing: CGFloat {
        value.trailing
    }
    
    // MARK: Wrapped Value
    
    public var wrappedValue: EdgeInsets {
        #if os(iOS)
        let metrics = UIFontMetrics(forTextStyle: textStyle.convertToSystemSpecificValue())
        let traits = UITraitCollection(preferredContentSizeCategory: dynamicTypeSize.convertToSystemSpecificValue())
        
        let top = metrics.scaledValue(for: top, compatibleWith: traits)
        let bottom = metrics.scaledValue(for: bottom, compatibleWith: traits)
        let leading = metrics.scaledValue(for: leading, compatibleWith: traits)
        let trailing = metrics.scaledValue(for: trailing, compatibleWith: traits)
        #endif
        
        return .init(
            top: top.between(minimumValue?.top, maximumValue?.top),
            leading: leading.between(minimumValue?.leading, maximumValue?.leading),
            bottom: bottom.between(minimumValue?.bottom, maximumValue?.bottom),
            trailing: trailing.between(minimumValue?.trailing, maximumValue?.trailing)
        )
    }
}


// MARK: - Previews

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
fileprivate struct PreviewView: View {
    @ScaledInsets(min: minInsets, max: maxInsets, relativeTo: .body)
    private var insets = defaultInsets
    
    private static var minInsets: EdgeInsets {
        .init(top: 30, leading: 20, bottom: 40, trailing: 20)
    }
    
    private static var maxInsets: EdgeInsets {
        .init(top: 45, leading: 30, bottom: 45, trailing: 30)
    }
    
    private static var defaultInsets: EdgeInsets {
        .init(top: 30, leading: 20, bottom: 40, trailing: 20)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
                    )
                    .font(.body.leading(.loose))
                    
                    Spacer()
                }
                .padding(insets)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .safeAreaInset(edge: .bottom, spacing: .zero) {
            HStack {
                Spacer()
                Text("t: \(Int(insets.top)), l: \(Int(insets.leading)) b: \(Int(insets.bottom)) t: \(Int(insets.trailing))")
                Spacer()
            }
            .font(.system(size: 16, weight: .bold, design: .monospaced))
            .padding()
            .background(.ultraThinMaterial)
            .overlay(alignment: .top) {
                Divider()
            }
        }
    }
}


@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
struct ScaledInsets_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
