//
//  KeyboardResponder.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 2/5/25.
//

import Foundation
import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        Publishers.Merge(willShow, willHide)
            .receive(on: RunLoop.main)
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellableSet)
    }
}
