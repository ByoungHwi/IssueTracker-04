//
//  IssueSlideViewDataSourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/05.
//

import Foundation

class DetailBottomSheetDataSourceManager: DetailBottomSheetDataManaging {
    
    var assignees: [Assignee] = []
    var labels: [Label] = []
    var milestone: Milestone?
    var issueFlag: Bool = false
    
    var numberOfSection: Int {
        BottomSheetSection.allCases.count
    }
    
    func count(of section: Int) -> Int {
        
        guard let section = BottomSheetSection(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .assignee:
            return assignees.count
        case .label:
            return labels.count
        case .milestone:
            return 1
        case .option:
            return 1
        }
    }
    
    func title(of indexPath: IndexPath) -> String {
        guard let section = BottomSheetSection(rawValue: indexPath.section) else {
            return ""
        }
        return section.title
    }
    
    func section(of indexPath: IndexPath) -> BottomSheetSection? {
        BottomSheetSection(rawValue: indexPath.section)
    }
    
    func labelTitle(of indexPath: IndexPath) -> String {
        guard let section = BottomSheetSection(rawValue: indexPath.section),
              section == .label else {
            return ""
        }
        
        return labels[indexPath.row].labelTitle
    }
}
