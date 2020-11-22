//
//  Milestone.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

struct Milestone: Codable, MilestoneDetailViewData {
    var milestoneNo: Int?
    let milestoneTitle: String?
    let milestoneDescription: String?
    let dueDate: Date?
    var percent: Float?
    var openIssueCount: Int?
    var closedIssueCount: Int?
    
    init(milestoneNo: Int? = 0, milestoneTitle: String? = "", milestoneDescription: String? = "", dueDate: Date? = Date(), percent: Float = 0, openIssueCount: Int = 0, closedIssueCount: Int = 0) {
        self.milestoneNo = milestoneNo
        self.milestoneTitle = milestoneTitle
        self.milestoneDescription = milestoneDescription
        self.dueDate = dueDate
        self.percent = percent
        self.openIssueCount = openIssueCount
        self.closedIssueCount = closedIssueCount
    }
}

protocol MilestoneDetailViewData {
    var milestoneNo: Int? { get }
    var milestoneTitle: String? { get }
    var dueDate: Date? { get }
    var milestoneDescription: String? { get }
    var percent: Float? { get }
    var openIssueCount: Int? { get }
    var closedIssueCount: Int? { get }
}
