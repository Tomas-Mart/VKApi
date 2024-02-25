//
//  VKManager.swift
//  VKApi
//
//  Created by Amina TomasMart on 24.02.2024.
//

import Foundation

class VKManager {
    
    func getAuthRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "51863877"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "offline"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.199")
        ]
        guard let reqUrl = urlComponents.url else {
            return nil
        }
        let req = URLRequest(url: reqUrl)
        return req
    }
    
    func getGroups(completion: @escaping ([VKGroup]) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "site,city"),
            URLQueryItem(name: "v", value: "5.199"),
        ]
        guard let url = urlComponents.url else {return}
        print(url)
        let requests = URLRequest(url: url)
        URLSession.shared.dataTask(with: requests) { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let resultData = data {
                do {
                    let groupItem = try JSONDecoder().decode(VKGroupResponse.self, from: resultData)
                    completion(groupItem.response.items)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

extension String {
    static let myToken = Session.shared.token
}
