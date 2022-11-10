//
//  AdButtonView.swift
//  AppodealTest
//
//  Created by bowtie on 09.11.22.
//

import SwiftUI

struct AdButtonView: View {
    // MARK: - PROPERTIES
    var title: String
    var action: () -> ()
    
    // MARK: - BODY
    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black)
                    .frame(height: 80)
                
                Text(title)
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - PREVIEW
struct AdButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AdButtonView(title: "Banner", action: {})
            .frame(width: 160)
    }
}
