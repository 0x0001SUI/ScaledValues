#if os(iOS)
import XCTest
import SwiftUI
@testable import ScaledValues


@available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
final class ScaledValuesTests: XCTestCase {
    func testConvertingFontStyleToSystemSpecificValue() throws {
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
    
    func testConvertingDynamicSizeToSystemSpecificValue() throws {
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
    
    func testConvertingFontWeightToSystemSpecificValue() throws {
        XCTAssertEqual(Font.Weight.ultraLight.convertToSystemSpecificValue(), UIFont.Weight.ultraLight)
        XCTAssertEqual(Font.Weight.thin.convertToSystemSpecificValue(), UIFont.Weight.thin)
        XCTAssertEqual(Font.Weight.light.convertToSystemSpecificValue(), UIFont.Weight.light)
        XCTAssertEqual(Font.Weight.regular.convertToSystemSpecificValue(), UIFont.Weight.regular)
        XCTAssertEqual(Font.Weight.medium.convertToSystemSpecificValue(), UIFont.Weight.medium)
        XCTAssertEqual(Font.Weight.semibold.convertToSystemSpecificValue(), UIFont.Weight.semibold)
        XCTAssertEqual(Font.Weight.bold.convertToSystemSpecificValue(), UIFont.Weight.bold)
        XCTAssertEqual(Font.Weight.heavy.convertToSystemSpecificValue(), UIFont.Weight.heavy)
        XCTAssertEqual(Font.Weight.black.convertToSystemSpecificValue(), UIFont.Weight.black)
    }
    
    @available(iOS 16.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, *)
    func testConvertingFontWidthToSystemSpecificValue() throws {
        XCTAssertEqual(Font.Width.condensed.convertToSystemSpecificValue(), UIFont.Width.condensed)
        XCTAssertEqual(Font.Width.expanded.convertToSystemSpecificValue(), UIFont.Width.expanded)
        XCTAssertEqual(Font.Width.compressed.convertToSystemSpecificValue(), UIFont.Width.compressed)
        XCTAssertEqual(Font.Width.standard.convertToSystemSpecificValue(), UIFont.Width.standard)
    }
}
#endif
