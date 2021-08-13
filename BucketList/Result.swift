//
//  Result.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-12.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}



