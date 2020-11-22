//
//  SlideSection.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

enum BottomSheetSection: Int, CaseIterable {
    case assignee
    case label
    case milestone
    case option
    
    var title: String {
        switch self {
        case .assignee:
            return "Assignees"
        case .label:
            return "Labels"
        case .milestone:
            return "Milestone"
        case .option:
            return ""
        }
    }
}
