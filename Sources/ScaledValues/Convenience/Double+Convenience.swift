//
//  Double+Convenience.swift
//  
//
//  Created by Dima Koskin on 12.11.2022.
//

import Foundation


internal extension Double {
    func between(_ minimumValue: Double? = nil, _ maximumValue: Double? = nil) -> Double {
        switch (minimumValue, maximumValue) {
        case (.some(let minimum), .some(let maximum)):
            return max(minimum, min(self, maximum))
        case (.none, .some(let maximum)):
            return min(self, maximum)
        case (.some(let minimum), .none):
            return max(minimum, self)
        case (.none, .none):
            return self
        }
    }
}
