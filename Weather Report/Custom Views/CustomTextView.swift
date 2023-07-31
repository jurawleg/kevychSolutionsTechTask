//
//  CustomTextView.swift
//  Weather Report
//
//  Created by MacBook on 01.08.2023.
//

import SwiftUI

struct CustomTextView: View {
    
    private var title: String
    private var value: Any
    
    public init(title: String, value: Any) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        Text("\(title) - \(String(describing: value))")
            .foregroundColor(.black)
            .fillWidth()
//            .multilineTextAlignment(.leading)
    }
}
