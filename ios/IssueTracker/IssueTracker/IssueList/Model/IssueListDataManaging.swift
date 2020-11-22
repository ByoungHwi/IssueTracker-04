//
//  IssueListDataManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol IssueListDataManaging {
    var itemCount: Int { get }
    subscript(indexPath: IndexPath) -> IssueItem { get }
    subscript(indexPaths: [IndexPath]) -> [IssueItem] { get }
    
    func loadIssueList(completion: @escaping  (Bool) -> Void)
    func add(title: String, content: String, completion: @escaping (Bool) -> Void)
    func deleteIssue(by issueNo: Int, completion: (IndexPath) -> Void)
    func deleteIssues(indexPaths: [IndexPath])
    func closeIssue(indexPath: IndexPath)
    func closeIssues(indexPaths: [IndexPath])
}
