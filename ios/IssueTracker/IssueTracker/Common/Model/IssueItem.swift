//
//  IssueItem.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import Foundation

struct IssueItem: Codable {
    let issue: Issue
    let assignees: [Assignee]
    let labels: [Label]
    let milestone: Milestone?
}

extension IssueItem: IssueListCollectionViewCellData {
    var issueNo: Int {
        issue.issueNo
    }
    
    var issueTitle: String {
        issue.issueTitle
    }
    
    var issueContent: String {
        issue.issueContent
    }
    
    var milestoneTitle: String? {
        milestone?.milestoneTitle
    }
    
}

protocol IssueListCollectionViewCellData {
    var issueNo: Int { get }
    var issueTitle: String { get }
    var issueContent: String { get }
    var milestoneTitle: String? { get }
    var labels: [Label] { get }
}
