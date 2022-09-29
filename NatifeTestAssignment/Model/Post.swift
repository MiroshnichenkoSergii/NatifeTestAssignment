//
//  Post.swift
//  NatifeTestAssignment
//
//  Created by Sergii Miroshnichenko on 26.09.2022.
//

import Foundation

struct Post: Codable {
    var postId: Int
    var timeshamp: Int
    var likes_count: Int
    
    var title: String
    var preview_text: String
    
    var image: String?
}
