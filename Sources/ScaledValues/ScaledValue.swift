//
//  ScaledValue.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//

import SwiftUI


// MARK: - ScalledValue

/// A dynamic property that scales an arbitrary layout value based on the current Dynamic Type settings.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@propertyWrapper public struct ScaledValue: DynamicProperty {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @State private var value: Double
    
    private let minimumValue: Double?
    private let maximumValue: Double?
    private let textStyle: Font.TextStyle

    // MARK: Initializer
    
    /// Creates the scaled metric with an unscaled value bounded by minimum and maximum values,  and a text style to scale relative to.
    public init(
        wrappedValue defaultValue: Double,
        min minimumValue: Double? = nil,
        max maximumValue: Double? = nil,
        relativeTo textStyle: Font.TextStyle = .body)
    {
        self.textStyle = textStyle
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self._value = State(wrappedValue: defaultValue)
    }
    
    // MARK: Wrapped Value
    
    public var wrappedValue: Double {
        #if os(iOS)
        let metrics = UIFontMetrics(forTextStyle: textStyle.convertToSystemSpecificValue())
        let traits = UITraitCollection(preferredContentSizeCategory: dynamicTypeSize.convertToSystemSpecificValue())
        let value = metrics.scaledValue(for: self.value, compatibleWith: traits)
        #endif
        
        switch (minimumValue, maximumValue) {
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
    @ScaledValue(relativeTo: .body)
    private var size: Double = 32

    @ScaledValue(min: 30, max: 78, relativeTo: .body)
    private var minMaxSize: Double = 32
    
    @State private var useMinMax = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.green)
                    .frame(
                        width: useMinMax ? minMaxSize : size,
                        height: useMinMax ? minMaxSize : size
                    )
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
                
                Text("\((useMinMax ? minMaxSize : size).formatted())")
                    
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
struct ScaledValue_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
