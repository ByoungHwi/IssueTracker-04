//
//  IssueListNetworkManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

protocol IssueListNetworkManaging {
    func requestAdd(title: String, content: String, completion: @escaping (Result<IssueItem, NetworkError>) -> Void)
    
    func requestList(completion: @escaping (Result<[IssueItem], NetworkError>) -> Void)
}
