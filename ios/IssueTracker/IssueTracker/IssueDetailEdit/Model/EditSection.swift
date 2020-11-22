//
//  EditSection.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

enum EditSection: Int, CaseIterable {
    case selected
    case unSelected
    
    var description: String {
        switch self {
        case .selected:
            return "SELECTED"
        case .unSelected:
            return ""
        }
    }
}
