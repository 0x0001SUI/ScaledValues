# ScaledValues

The library provides you with an alternative to the [**`@ScaledMetric`**](https://developer.apple.com/documentation/swiftui/scaledmetric) dynamic property.

It has two dynamic property wrappers:
    
- **`@ScaledPointSize`**
- **`@ScaledValue`**

You'll want to use **`@ScaledPointSize`** for a custom font size and **`@ScaledValue`** for an arbitrary layout value.

Both dynamic properties scale values according to the current [Dynamic Type size](https://developer.apple.com/documentation/swiftui/dynamictypesize) and provide you with the ability to define *minimum* and *maximum* values.

```swift
import SwiftUI
import ScaledValues


struct ContentView: View {
    @ScaledPointSize(min: 15, max: 30, relativeTo: .body)
    private var fontSize = 16.0

    @ScaledValue(min: 30, max: 60, relativeTo: .body)
    private var shapeSize = 32.0
    
    @ScaledValue(min: 8, max: 15, relativeTo: .body)
    private var shapeRadius = 10.0

    var body: some View {
        RoundedRectangle(
            cornerRadius: shapeRadius, 
            style: .continuous
        )
        .fill(.green)
        .frame(width: shapeSize, height: shapeSize)
        .overlay {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.system(size: fontSize))
        }
    }
}
```

