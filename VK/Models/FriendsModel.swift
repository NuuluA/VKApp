//
//  FriendsModel.swift
//  VK
//
//  Created by Арген on 15.04.2022.
//

import Foundation

struct FriendsResponse: Codable {
    let response: Friends?
}

struct Friends: Codable {
    let count: Int?
    let items: [FriendsArray]?
}

struct FriendsArray: Codable {
    let id: Int?
    let photo100: String?
    let lastName, trackCode, firstName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case trackCode = "track_code"
        case firstName = "first_name"
    }
}
