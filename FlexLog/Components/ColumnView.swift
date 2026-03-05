//
//  ColumnView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 03.03.2026.
//

import Foundation
import SwiftUI

struct ColumnView: View {
    
    @Binding var text: String
    let label: String
    let width: CGFloat?
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
                    Text(label)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.gray)
            TextField("", text: $text)
                    .padding(.horizontal, 12)
                    .frame(height: 45)
                    .frame(maxWidth: width == nil ? .infinity : width)
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                    .foregroundStyle(.white)
                }
    }
    
}
