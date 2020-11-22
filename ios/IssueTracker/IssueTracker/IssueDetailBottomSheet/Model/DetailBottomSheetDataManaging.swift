//
//  IssueSlideViewDataManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol DetailBottomSheetDataManaging {
    var assignees: [Assignee] { get set }
    var labels: [Label] { get set }
    var milestone: Milestone? { get set }
    var issueFlag: Bool { get set }
    var numberOfSection: Int { get }
    
    func count(of section: Int) -> Int
    func title(of indexPath: IndexPath) -> String
    func section(of indexPath: IndexPath) -> BottomSheetSection?
    func labelTitle(of indexPath: IndexPath) -> String
}
