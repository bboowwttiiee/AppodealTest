//
//  ActivityIndicator.swift
//  AppodealTest
//
//  Created by bowtie on 09.11.22.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isStopped: Bool
    let style: UIActivityIndicatorView.Style = .medium

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isStopped ?  uiView.stopAnimating() : uiView.startAnimating()
    }
}
