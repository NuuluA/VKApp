//
//  APICaller.swift
//  VK
//
//  Created by Арген on 01.04.2022.
//

import Foundation
import Alamofire

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    static let shared = APICaller()
    private init() {}
    
    let baseURL = "https://api.vk.com/method"
    let access_token = AccessToken.shared.token
    let userID = "8138404"
    let version = "5.81"
    
    func getFriends(completion: @escaping (Result<[FriendsArray],Error>) -> Void) {
        let method = "/friends.get"
        let params: Parameters = [
            "user_id": userID,
            "access_token": access_token,
            "order": "random",
            "count": 30,
            "fields": "photo_100",
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
            
            do {
                let result = try JSONDecoder().decode(FriendsResponse.self, from: data)
                completion(.success(result.response?.items ?? []))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
}


