//
//  File.swift
//  
//
//  Created by Dima Koskin on 13.11.2022.
//

import Foundation


internal extension Comparable {
    func minimum(_ lhs: Self, _ rhs: Self) -> Self {
        return lhs < rhs ? lhs : rhs
    }
    
    func maximum(_ lhs: Self, _ rhs: Self) -> Self {
        return lhs > rhs ? lhs : rhs
    }
    
    func between(_ minimumValue: Self? = nil, _ maximumValue: Self? = nil) -> Self {
        switch (minimumValue, maximumValue) {
        case (.some(let minimum), .some(let maximum)):
            return max(minimum, self.minimum(self, maximum))
        case (.none, .some(let maximum)):
            return self.minimum(self, maximum)
        case (.some(let minimum), .none):
            return self.maximum(minimum, self)
        case (.none, .none):
            return self
        }
    }
}
