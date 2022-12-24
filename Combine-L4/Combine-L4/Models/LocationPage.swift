//
//  LocationPage.swift
//  Combine-L4
//
//  Created by Dmitry Belov on 20.12.2022.
//

import Foundation

public struct LocationPage: Codable {
    
    public var info: PageInfo
    public var results: [Location]

    public init(info: PageInfo, results: [Location]) {
        self.info = info
        self.results = results
    }
}
