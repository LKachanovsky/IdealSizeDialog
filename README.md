# Installation
Add the following line to your `Package.swift` file under the `dependencies` section:
```
dependencies: [
    .package(url: "https://github.com/LKachanovsky/IdealSizeDialog.git", from: "1.0.0")
]
```
Then, add your library as a dependency in any target that requires it:
```
.target(
    name: "YourTargetName",
    dependencies: [
        "https://github.com/LKachanovsky/IdealSizeDialog.git"
    ]
)
```
Alternatively, you can add it via Xcode:
1. Click on File -> Add Package Dependencies...
2. Enter the URL: https://github.com/LKachanovsky/IdealSizeDialog.git
# Usage
```
import SwiftUI
import IdealSizeDialog

struct ContentView: View {
    @State private var doShowDialog: Bool = false
    
    var body: some View {
        ZStack {
            Button(action: { doShowDialog = true }) {
                Text("Find your perfect fit")
            }
        }
        
        if doShowDialog {
            IdealSizeDialog(
                onDismiss: { doShowDialog = false },
                onOkClicked: { doShowDialog = false }
            )
        }
    }
}
```
