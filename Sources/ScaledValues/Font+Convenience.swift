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
#endif
