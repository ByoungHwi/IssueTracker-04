//
//  IssueDetail.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/05.
//

import Foundation

struct IssueDetail: Codable, DetailHeaderData {
    var issue: Issue
    let detailInfo: DetailInfo
    let milestone: Milestone?
    let labels: [Label]
    let assignees: [Assignee]
    var comments: [Comment]
}

struct DetailInfo: Codable {
    let authorImg: String
}

protocol DetailHeaderData {
    var issue: Issue { get }
    var detailInfo: DetailInfo { get }
}
