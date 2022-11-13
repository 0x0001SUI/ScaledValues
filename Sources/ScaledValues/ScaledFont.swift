//
//  ScaledFont.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//

import SwiftUI


// MARK: - ScaledFont

/// A dynamic property that scales a font based on the current Dynamic Type settings.
@available(iOS 16.0, macOS 13.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, *)
@propertyWrapper public struct ScaledFont: DynamicProperty {
    public typealias SmallCaps = ScaledFontConfiguration.SmallCaps

    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
        
    private let textStyle: Font.TextStyle
    private let configuration: ScaledFontConfiguration
    
    // MARK: Initializer
    
    /// Creates a scaled font using the provided settings relative to the provided text style.
    public init(
        size currentPointSize: Double,
        min minimumPointSize: Double? = nil,
        max maximumPointSize: Double? = nil,
        weight: Font.Weight? = nil,
        design: Font.Design? = nil,
        leading: Font.Leading? = nil,
        width: Font.Width? = nil,
        smallCaps: SmallCaps? = nil,
        italic: Bool = false,
        monospacedDigit: Bool = false,
        relativeTo textStyle: Font.TextStyle = .body)
    {
        self.configuration = .system(
            size: currentPointSize,
            min: minimumPointSize,
            max: maximumPointSize,
            weight: weight,
            design: design,
            leading: leading,
            width: width,
            smallCaps: smallCaps,
            italic: italic,
            monospacedDigit: monospacedDigit
        )
        self.textStyle = textStyle
    }
    
    /// Creates a scaled font using the provided configuration relative to the provided text style.
    public init(_ configuration: ScaledFontConfiguration, relativeTo textStyle: Font.TextStyle = .body) {
        self.configuration = configuration
        self.textStyle = textStyle
    }
    
    // MARK: Wrapped Value
    
    public var wrappedValue: Font {
        #if os(iOS)
        let metrics = UIFontMetrics(forTextStyle: textStyle.convertToSystemSpecificValue())
        let traits = UITraitCollection(preferredContentSizeCategory: dynamicTypeSize.convertToSystemSpecificValue())

        let uiFont = metrics.scaledFont(
            for: .systemFont(
                ofSize: configuration.currentPointSize,
                weight: configuration.weight?.convertToSystemSpecificValue() ?? .regular
            ),
            compatibleWith: traits
        )
        
        let currentPointSize = Double(uiFont.pointSize)
        #else
        let currentPointSize = configuration.currentPointSize
        #endif

        var font: Font = .system(
            size: currentPointSize.between(configuration.minimumPointSize, configuration.maximumPointSize),
            weight: configuration.weight,
            design: configuration.design
        )
        
        if let leading = configuration.leading {
            font = font.leading(leading)
        }

        if let width = configuration.width {
            font = font.width(width)
        }
        
        if let smallCaps = configuration.smallCaps {
            switch smallCaps {
            case .smallCaps:
                font = font.smallCaps()
            case .lowercaseSmallCaps:
                font = font.lowercaseSmallCaps()
            case .uppercaseSmallCaps:
                font = font.uppercaseSmallCaps()
            }
        }
        
        if configuration.italic {
            font = font.italic()
        }
        
        if configuration.monospacedDigit {
            font = font.monospacedDigit()
        }
        
        return font
    }
}


// MARK: - ScaledFontConfiguration

@available(iOS 16.0, macOS 13.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, *)
public extension ScaledFont {
    struct ScaledFontConfiguration {
        
        public enum SmallCaps {
            case smallCaps, lowercaseSmallCaps, uppercaseSmallCaps
        }
        
        public let currentPointSize: Double
        public let minimumPointSize: Double?
        public let maximumPointSize: Double?
        public let weight: Font.Weight?
        public let design: Font.Design?
        public let leading: Font.Leading?
        public let width: Font.Width?
        public let smallCaps: SmallCaps?
        public let italic: Bool
        public let monospacedDigit: Bool

        private init(
            currentPointSize: Double,
            minimumPointSize: Double?,
            maximumPointSize: Double?,
            weight: Font.Weight?,
            design: Font.Design?,
            leading: Font.Leading?,
            width: Font.Width?,
            smallCaps: SmallCaps?,
            italic: Bool,
            monospacedDigit: Bool
        ) {
            self.currentPointSize = currentPointSize
            self.minimumPointSize = minimumPointSize
            self.maximumPointSize = maximumPointSize
            self.weight = weight
            self.design = design
            self.leading = leading
            self.width = width
            self.smallCaps = smallCaps
            self.italic = italic
            self.monospacedDigit = monospacedDigit
        }
        
        static func system(
            size currentPointSize: Double,
            min minimumFontSize: Double? = nil,
            max maximumFontSize: Double? = nil,
            weight: Font.Weight? = nil,
            design: Font.Design? = nil,
            leading: Font.Leading? = nil,
            width: Font.Width? = nil,
            smallCaps: SmallCaps? = nil,
            italic: Bool = false,
            monospacedDigit: Bool = false
        ) -> Self {
            return .init(
                currentPointSize: currentPointSize,
                minimumPointSize: minimumFontSize,
                maximumPointSize: maximumFontSize,
                weight: weight,
                design: design,
                leading: leading,
                width: width,
                smallCaps: smallCaps,
                italic: italic,
                monospacedDigit: monospacedDigit
            )
        }
    }
}


// MARK: - Previews

@available(iOS 16.0, macOS 13.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, *)
fileprivate struct PreviewView: View {
    @ScaledFont(.system(size: 22, design: .serif, leading: .loose))
    private var font: Font

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("The form is the solution to the problem; the context defines the problem.")
                    .font(font)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}


@available(iOS 16.0, macOS 13.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, *)
struct ScaledFont_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}

