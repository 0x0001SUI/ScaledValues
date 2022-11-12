//
//  DynamicTypeSize+Convenience.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//
#if os(iOS)
import SwiftUI


@available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
internal extension DynamicTypeSize {
    func convertToSystemSpecificValue() -> UIContentSizeCategory {
        switch self {
        case .xSmall:
            return .extraSmall
        case .small:
            return .small
        case .medium:
            return .medium
        case .large:
            return .large
        case .xLarge:
            return .extraLarge
        case .xxLarge:
            return .extraExtraLarge
        case .xxxLarge:
            return .extraExtraExtraLarge
        case .accessibility1:
            return .accessibilityMedium
        case .accessibility2:
            return .accessibilityLarge
        case .accessibility3:
            return .accessibilityExtraLarge
        case .accessibility4:
            return .accessibilityExtraExtraLarge
        case .accessibility5:
            return .accessibilityExtraExtraExtraLarge
        @unknown default:
            fatalError("Unknown DynamicTypeSize")
        }
    }
}
#endif
