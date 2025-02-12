# 🚀 Zoom Navigation Transition – New in iOS 18! 🎉  

iOS 18 introduces a new way to navigate between views in SwiftUI – **Zoom Navigation Transition**. This smooth and visually appealing animation makes transitions between screens more intuitive and engaging.  

## 📌 Demonstration  
<img src="https://github.com/user-attachments/assets/fc79838b-01dc-4637-9fcf-db6af37480a4" width="300">

## 🔹 How It Works  

Instead of the standard push transition, **Zoom Navigation Transition** shrinks the current view while seamlessly expanding the new screen. This effect works perfectly for apps where users transition from an overview to a detailed view (e.g., list → details).  

It also enables **intuitive back navigation** using gestures, making the user experience even smoother.  

## 🔹 Implementation  

To implement **Zoom Navigation Transition**, you need to:  

✅ Define the **source of the animation** using `matchedTransitionSource`  
✅ Add the **modifier** `.navigationTransition(.zoom)` to the destination view  

Both elements must share the same `@Namespace` variable to ensure a smooth and natural animation.  

### 📌 Example Code  

```swift
import SwiftUI

struct TestView: View {
    @State private var route: [String] = []
    @Namespace private var transitionNamespace
    
    var body: some View {
        NavigationStack(path: $route) {
            VStack {
                Rectangle()
                    .fill(.blue.gradient)
                    .frame(width: 200, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .matchedTransitionSource(id: "rectangle", in: transitionNamespace)
                    .onTapGesture {
                        route.append("details")
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "details":
                    Rectangle()
                        .fill(.blue.gradient)
                        .toolbarVisibility(.hidden, for: .navigationBar)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .navigationTransition(
                            .zoom(
                                sourceID: "rectangle",
                                in: transitionNamespace
                            )
                        )
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    TestView()
}
