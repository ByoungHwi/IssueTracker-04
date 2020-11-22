//
//  IssueDetailDataManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol IssueDetailDataManaging {
    var detailItem: IssueDetail? { get set }
    var commentCount: Int { get }
    subscript(indexPath: IndexPath) -> Comment? { get }
    
    func loadDetailItem(issueNo: Int, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void)
    func addComment(comment: Comment, completion: @escaping (Bool) -> Void)
    func setIssueFlag(_ flag: Bool)
}
