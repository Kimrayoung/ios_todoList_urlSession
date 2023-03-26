//
//  DataType.swift
//  TodoUrlSession
//
//  Created by 김라영 on 2023/03/21.
//

import Foundation
import UIKit

// MARK: - 할일 목록 전체 response
// Json -> struct, class : decoding
// struct, class -> Json : Encoding
struct TodoResponse: Codable {
    let data: [TodoData]?
    let meta: Meta?
    let message: String?
}

// MARK: - 할일 목록 전체 data
struct TodoData: Codable {
    let id: Int?
    var title, content: String?
    let images: [Image]?
    let isPublished: Bool?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, content, images
        case isPublished = "is_published"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Image
struct Image: Codable {
    let url: String?
}

// MARK: - Meta
struct Meta: Codable {
    let currentPage, from, lastPage, perPage: Int?
    let to, total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case perPage = "per_page"
        case to, total
    }
}
