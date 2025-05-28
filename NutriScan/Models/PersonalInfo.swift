//
//  PersonalInfo.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import Foundation


struct PersonalInfo: Codable, Equatable {
    let gender: String
    let height: Double
    let weight: Double
    let age: Int
}
