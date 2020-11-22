//
//  IssueDetailNetworkManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol IssueDetailNetworkManaging {
    func addComment(comment: Comment, completion: @escaping (Result<Comment, NetworkError>) -> Void)
    func requestIssueDetail(issueNo: Int,
                            completion: @escaping (Result<IssueDetail, NetworkError>) -> Void)
}
