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
    
    let baseURL = "https://api.vk.com/method/"
    let access_token = AccessToken.shared.token
    let userID = "8142557"
    let version = "5.81"
    
    func getFriends(completion: @escaping (Result<[FriendsItem],Error>) -> Void) {
        let method = "friends.get"
        let params: Parameters = [
            "user_id": userID,
            "access_token": access_token,
            "order": "random",
            "count": 30,
            "fields": "photo_100",
            "offset": 5,
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
            //            print(data.prettyJSON as Any)
            do {
                let result = try JSONDecoder().decode(FriendsResponse.self, from: data)
                completion(.success(result.response?.items ?? []))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    
    func getGroups(completion: @escaping (Result<String,Error>) -> Void) {
        let method = "groups.get"
        let params: Parameters = [
            "user_id": userID,
            "access_token": access_token,
            "filter": "admin, editor, moder, advertiser, groups",
            "count": 30,
            "fields": "city, country, place, description",
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
                        print(data.prettyJSON as Any)
//            do {
//                let result = try JSONDecoder().decode(FriendsResponse.self, from: data)
//                completion(.success(result.response?.items ?? []))
//            } catch {
//                completion(.failure(APIError.failedToGetData))
//            }
        }
    }
    
    func getUser(completion: @escaping (Result<String,Error>) -> Void) {
        let method = "groups.get"
        let params: Parameters = [
            "user_id": userID,
            "access_token": access_token,
            "fields": "photo_id, sex, bdate, city, country, photo_50",
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
                        print(data.prettyJSON as Any)
//            do {
//                let result = try JSONDecoder().decode(FriendsResponse.self, from: data)
//                completion(.success(result.response?.items ?? []))
//            } catch {
//                completion(.failure(APIError.failedToGetData))
//            }
        }
    }
}
