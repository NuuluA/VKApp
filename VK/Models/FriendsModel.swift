//
//  FriendsModel.swift
//  VK
//
//  Created by Арген on 15.04.2022.
//

import Foundation

struct FriendsResponse: Codable {
    let response: Response?
}

struct Response: Codable {
    let count: Int?
    let items: [FriendsItem]?
}

struct FriendsItem: Codable {
    let id: Int?
    let lastName, trackCode, firstName: String?
    let photo100: String?
    let deactivated: String?
    let lists: [Int]?

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
        case deactivated, lists
    }
}
