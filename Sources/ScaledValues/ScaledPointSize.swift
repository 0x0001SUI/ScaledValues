//
//  ScaledPointSize.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//

import SwiftUI


// MARK: - ScalledPointSize

/// A dynamic property that scales a font size value based on the current Dynamic Type settings.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@propertyWrapper public struct ScaledPointSize: DynamicProperty {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @State private var value: Double
    
    private let textStyle: Font.TextStyle
    private let minimumPointSize: Double?
    private let maximumPointSize: Double?
    
    // MARK: Initializer
    
    /// Creates the scaled metric with an unscaled font size value in points bounded by minimum and maximum values,  and a text style to scale relative to.
    public init(
        wrappedValue defaultValue: Double,
        min minimumPointSize: Double? = nil,
        max maximumPointSize: Double? = nil,
        relativeTo textStyle: Font.TextStyle = .body)
    {
        self.textStyle = textStyle
        self.minimumPointSize = minimumPointSize
        self.maximumPointSize = maximumPointSize
        self._value = State(wrappedValue: defaultValue)
    }
    
    // MARK: Wrapped Value
    
    public var wrappedValue: Double {
        #if os(iOS)
        let metrics = UIFontMetrics(forTextStyle: textStyle.convertToSystemSpecificValue())
        let traits = UITraitCollection(preferredContentSizeCategory: dynamicTypeSize.convertToSystemSpecificValue())
        let font = metrics.scaledFont(for: .systemFont(ofSize: value), compatibleWith: traits)
        let value = font.pointSize
        #endif

        switch (minimumPointSize, maximumPointSize) {
        case (.some(let minimum), .some(let maximum)):
            return max(minimum, min(value, maximum))
        case (.none, .some(let maximum)):
            return min(value, maximum)
        case (.some(let minimum), .none):
            return max(minimum, value)
        case (.none, .none):
            return value
        }
    }
}


// MARK: - Previews

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
fileprivate struct PreviewView: View {
    @ScaledPointSize(relativeTo: .body)
    private var pointSize: Double = 14.0

    @ScaledPointSize(min: 13, max: 30, relativeTo: .body)
    private var minMaxPointSize: Double = 14.0
    
    @State private var useMinMax = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("Hello World")
                    .font(.system(size: useMinMax ? minMaxPointSize : pointSize))
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .safeAreaInset(edge: .bottom, spacing: .zero) {
            HStack {
                Toggle(isOn: $useMinMax, label: { Text("Use bounds") })
                    .toggleStyle(.switch)
                    .labelsHidden()
                
                Spacer()
                
                Text("\((useMinMax ? minMaxPointSize : pointSize).formatted()) pt")
                    
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
struct ScaledPointSize_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
