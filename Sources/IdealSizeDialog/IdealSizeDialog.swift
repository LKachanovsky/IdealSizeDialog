//
//  IdealSizeDialog.swift
//  IdealSizeDialog
//
//  Created by Leo Kachanovskyi on 19.02.2025.
//

import SwiftUI

public struct IdealSizeDialog: View {
    @State private var result: Size? = nil
    var onDismiss: () -> Void
    var onOkClicked: () -> Void
    
    public init(result: Size? = nil, onDismiss: @escaping () -> Void, onOkClicked: @escaping () -> Void) {
        self.result = result
        self.onDismiss = onDismiss
        self.onOkClicked = onOkClicked
    }
    
    public var body: some View {
        ZStack {
            if let result = result {
                Output(size: result, onOkClicked: onOkClicked)
            } else {
                Input { size in
                    result = size
                }
            }
        }
        .background(Color(.systemFill))
        .cornerRadius(19)
        .padding(.horizontal, 24)
    }
}

struct Input: View {
    @State private var height: String = ""
    @State private var weight: String = ""
    var onGetSizeRecommendationClicked: (Size) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Find Your Perfect Fit")
                .font(.system(size: 18, weight: .bold))
            
            HStack(spacing: 8) {
                Text("Height:")
                
                TextField("", text: $height)
                    .keyboardType(.numberPad)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 4)
                    .border(Color.gray)
                
                Text("cm")
            }
            
            HStack(spacing: 8) {
                Text("Weight:")
                
                TextField("", text: $weight)
                    .keyboardType(.numberPad)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 4)
                    .border(Color.gray)
                
                Text("kg")
            }
            
            Button(action: {
                guard let heightValue = Float(height), let weightValue = Float(weight), heightValue > 0, weightValue > 0 else { return }
                let result = calculateSizeRecommendation(height: heightValue, weight: weightValue)
                onGetSizeRecommendationClicked(result)
            }) {
                Text("Get Size Recommendation")
            }
            .padding(.top, 24)
        }
        .padding(24)
    }
}

struct Output: View {
    var size: Size
    var onOkClicked: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Recommended Size: \(size.name)")
                .font(.system(size: 18, weight: .bold))
            
            Text("Based on your information, the best size for you is \(size.name).")
                .padding(.top, 24)
            
            Button(action: onOkClicked) {
                Text("OK")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 24)
        }
        .padding(16)
    }
}

public enum Size: String {
    case S, M, L, XL
    
    var name: String {
        return self.rawValue
    }
}

func calculateSizeRecommendation(height: Float, weight: Float) -> Size {
    let heightM2 = (height / 100) * (height / 100)
    let bmi = weight / heightM2
    switch bmi {
    case ..<18.5:
        return .S
    case 18.5..<25:
        return .M
    case 25..<30:
        return .L
    default:
        return .XL
    }
}

#Preview {
    IdealSizeDialog(onDismiss: { }, onOkClicked: { })
}
