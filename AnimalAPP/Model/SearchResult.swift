//
//  SearchResult.swift
//  AnimalAPP
//
//  Created by hui liu on 12/8/20.
//

import Foundation

struct SearchResult: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let imageURL: String
    let title: String
    let score: Float
    let url: String
    
    private enum CodingKeys : String, CodingKey {
        case imageURL = "image_url"
        case title
        case score
        case url
    }
}
