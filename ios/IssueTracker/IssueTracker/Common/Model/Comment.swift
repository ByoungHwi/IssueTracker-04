//
//  Comment.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

struct Comment: Codable, CommentCellData {
    let issueNo: Int?
    var commentNo: Int
    let comment, authorName, authorImg: String
    let commentDate: Date
}

protocol CommentCellData {
    var comment: String { get }
    var authorName: String { get }
    var authorImg: String { get }
    var commentDate: Date { get }
}
