#if os(iOS)
import XCTest
import SwiftUI
@testable import ScaledValues


@available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
final class ScaledValuesTests: XCTestCase {
    func textConvertingFontStyleToSystemSpecificValue() throws {
        for fontStyle in Font.TextStyle.allCases {
            let converted = fontStyle.convertToSystemSpecificValue()
            
            switch fontStyle {
            case .largeTitle:
                XCTAssertEqual(converted, .largeTitle)
            case .title:
                XCTAssertEqual(converted, .title1)
            case .title2:
                XCTAssertEqual(converted, .title2)
            case .title3:
                XCTAssertEqual(converted, .title3)
            case .headline:
                XCTAssertEqual(converted, .headline)
            case .subheadline:
                XCTAssertEqual(converted, .subheadline)
            case .body:
                XCTAssertEqual(converted, .body)
            case .callout:
                XCTAssertEqual(converted, .callout)
            case .footnote:
                XCTAssertEqual(converted, .footnote)
            case .caption:
                XCTAssertEqual(converted, .caption1)
            case .caption2:
                XCTAssertEqual(converted, .caption2)
            @unknown default:
                fatalError("Unknown Font.TextStyle.")
            }
        }
    }
    
    func textConvertingDynamicSizeToSystemSpecificValue() throws {
        for dynamicTypeSize in DynamicTypeSize.allCases {
            let converted = dynamicTypeSize.convertToSystemSpecificValue()
            
            switch dynamicTypeSize {
            case .xSmall:
                XCTAssertEqual(converted, .extraSmall)
            case .small:
                XCTAssertEqual(converted, .small)
            case .medium:
                XCTAssertEqual(converted, .medium)
            case .large:
                XCTAssertEqual(converted, .large)
            case .xLarge:
                XCTAssertEqual(converted, .extraLarge)
            case .xxLarge:
                XCTAssertEqual(converted, .extraExtraLarge)
            case .xxxLarge:
                XCTAssertEqual(converted, .extraExtraExtraLarge)
            case .accessibility1:
                XCTAssertEqual(converted, .accessibilityMedium)
            case .accessibility2:
                XCTAssertEqual(converted, .accessibilityLarge)
            case .accessibility3:
                XCTAssertEqual(converted, .accessibilityExtraLarge)
            case .accessibility4:
                XCTAssertEqual(converted, .accessibilityExtraExtraLarge)
            case .accessibility5:
                XCTAssertEqual(converted, .accessibilityExtraExtraExtraLarge)
            @unknown default:
                fatalError("Unknown DynamicTypeSize.")
            }
        }
    }
}
#endif
