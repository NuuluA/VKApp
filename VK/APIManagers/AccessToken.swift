//
//  AccessToken.swift
//  VK
//
//  Created by Арген on 01.04.2022.
//

import Foundation

class AccessToken {
    static let shared = AccessToken()
    
    private init() {}
    
    var token: String = ""
}
