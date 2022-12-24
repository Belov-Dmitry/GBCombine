//
//  Location.swift
//  Combine-L4
//
//  Created by Dmitry Belov on 20.12.2022.
//

import Foundation

public struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
}
