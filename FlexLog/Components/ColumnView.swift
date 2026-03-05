//
//  ColumnView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 03.03.2026.
//

import Foundation
import SwiftUI

struct ColumnView: View {
    
    let label: String
    let width: CGFloat?
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
                    Text(label)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.gray)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 45)
                        .frame(maxWidth: width == nil ? .infinity : width)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                }
    }
    
}
