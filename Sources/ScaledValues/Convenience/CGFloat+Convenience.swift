//
//  CGFloat+Convenience.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//

import Foundation


internal extension CGFloat {
    func between(_ minimumValue: CGFloat? = nil, _ maximumValue: CGFloat? = nil) -> CGFloat {
        switch (minimumValue, maximumValue) {
        case (.some(let minimum), .some(let maximum)):
            return CGFloat.maximum(minimum, CGFloat.minimum(self, maximum))
        case (.none, .some(let maximum)):
            return CGFloat.minimum(self, maximum)
        case (.some(let minimum), .none):
            return CGFloat.maximum(minimum, self)
        case (.none, .none):
            return self
        }
    }
}
