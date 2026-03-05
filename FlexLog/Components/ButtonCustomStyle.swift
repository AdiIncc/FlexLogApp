//
//  ButtonCustomStyle.swift
//  FlexLog
//
//  Created by Adrian Inculet on 03.03.2026.
//

import Foundation
import SwiftUI

struct ButtonCustomStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 20, weight: .semibold))
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .foregroundStyle(.white)
            .background(Color.button)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
}
