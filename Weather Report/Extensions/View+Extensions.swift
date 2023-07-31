//
//  View+Extensions.swift
//  Weather Report
//
//  Created by MacBook on 31.07.2023.
//

import SwiftUI

extension View {
    func fillWidth() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
}
