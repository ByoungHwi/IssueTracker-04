//
//  MilestoneNetworkManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol MilestoneNetworkManaging {
    func load(completion: @escaping (Result<[Milestone], NetworkError>) -> Void)
    func add(milestone: Milestone, completion: @escaping (Result<Int, NetworkError>) -> Void)
    func update(milestone: Milestone, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func delete(milestoneNo: Int, completion: @escaping (Result<Void, NetworkError>) -> Void)
}
