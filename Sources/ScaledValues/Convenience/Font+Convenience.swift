//
//  Font+Convenience.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//
#if os(iOS)
import SwiftUI


@available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
internal extension Font.TextStyle {
    func convertToSystemSpecificValue() -> UIFont.TextStyle {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption:
            return .caption1
        case .caption2:
            return .caption2
        @unknown default:
            fatalError("Unknown Font.TextStyle...")
        }
    }
}

@available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
internal extension Font.Weight {
    func convertToSystemSpecificValue() -> UIFont.Weight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        default:
            fatalError("Unknown Font.Weight...")
        }
    }
}

@available(iOS 16.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, *)
internal extension Font.Width {
    func convertToSystemSpecificValue() -> UIFont.Width {
        switch self {
        case .compressed: return .compressed
        case .condensed: return .condensed
        case .expanded: return .expanded
        case .standard: return .standard
        default:
            fatalError("Unknown Font.Width...")
        }
    }
}

#endif
