//
//  dogApiModel.swift
//  The_Dog_List
//
//  Created by Maria Tupich on 20/04/22.
//

import Foundation

struct Response: Codable {
    let id: String
    let index: Int
    let name: String
    let wikilink: String
    let image: String
    let note: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case index, name, wikilink, image, note
    }
}
