//
//  TextFieldStyle.swift
//  FlexLog
//
//  Created by Adrian Inculet on 02.03.2026.
//

import Foundation
import SwiftUI

struct MainTextField: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .shadow(color: .white.opacity(0.7), radius: 10, x: 0, y: 5)
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
    
}
