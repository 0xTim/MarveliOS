//
//  CharacterResponseModels.swift
//  MarvelList
//
//  Created by Tim Condon on 24/10/2019.
//  Copyright © 2019 Tim Condon. All rights reserved.
//

import Foundation

struct CharacterResponse: Codable {
    let data: CharacterResponseData
}

struct CharacterResponseData: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: CharacterImage
}

struct CharacterImage: Codable {
    let path: String
    let `extension`: String
}
