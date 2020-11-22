//
//  Issue.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

struct Issue: Codable {
    let issueNo: Int
    let issueTitle, issueContent: String
    var issueFlag: Int
    let issueDate: Date
    let issueAuthorNo: Int
    let issueAuthorName: String
    
    var isOpen: Bool {
        get {
            issueFlag == 1
        }
        set {
            issueFlag = newValue ? 1 : 0
        }
    }
}
