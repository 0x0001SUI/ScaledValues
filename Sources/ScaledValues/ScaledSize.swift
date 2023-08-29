//
//  ScaledSize.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//

import SwiftUI


// MARK: - ScaledSize

/// A dynamic property that scales an CGSize value based on the current Dynamic Type settings.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@propertyWrapper public struct ScaledSize: DynamicProperty {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @State private var value: CGSize
    
    private let minimumSize: CGSize?
    private let maximumSize: CGSize?
    private let textStyle: Font.TextStyle

    // MARK: Initializer
    
    /// Creates the scaled metric with an unscaled CGSize value bounded by minimum and maximum sizes,  and a text style to scale relative to.
    public init(
        wrappedValue defaultSize: CGSize,
        min minimumSize: CGSize? = nil,
        max maximumSize: CGSize? = nil,
        relativeTo textStyle: Font.TextStyle = .body)
    {
        self.textStyle = textStyle
        self.minimumSize = minimumSize
        self.maximumSize = maximumSize
        self._value = State(wrappedValue: defaultSize)
    }
    
    private var width: CGFloat {
        value.width
    }
    
    private var height: CGFloat {
        value.height
    }
    
    // MARK: Wrapped Value
    
    public var wrappedValue: CGSize {
        #if os(iOS)
        let metrics = UIFontMetrics(forTextStyle: textStyle.convertToSystemSpecificValue())
        let traits = UITraitCollection(preferredContentSizeCategory: dynamicTypeSize.convertToSystemSpecificValue())
        let width = metrics.scaledValue(for: width, compatibleWith: traits)
        let height = metrics.scaledValue(for: height, compatibleWith: traits)
        #endif
        
        return CGSize(
            width: width.between(minimumSize?.width, maximumSize?.width),
            height: height.between(minimumSize?.height, maximumSize?.height)
        )
    }
}


// MARK: - Previews

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
fileprivate struct PreviewView: View {
    @ScaledSize private var size = CGSize(width: 42, height: 32)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.green)
                    .frame(width: size.width, height: size.height)
            }
            .padding()
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
        .safeAreaInset(edge: .bottom, spacing: .zero) {
            HStack {
                Spacer()
                Text("\(Int(size.width))x\(Int(size.height))")
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
struct ScaledSize_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
