//
//  RoundedCorner.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape { // use to set radius of specific corners
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
