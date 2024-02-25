//
//  VKGroupItem.swift
//  VKApi
//
//  Created by Amina TomasMart on 24.02.2024.
//

import Foundation

struct VKGroupResponse: Decodable {
    let response: VKGroupItem
}

struct VKGroupItem: Decodable {
    let count: Int
    let items: [VKGroup]
}

struct VKGroup: Decodable {
    let name: String
    let screenName: String
    let photo50: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case screenName = "screen_name"
        case photo50 = "photo_50"
    }
}


