//
//  MilestoneDataManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol MilestoneDataManaging {
    var itemCount: Int { get }
    subscript(indexPath: IndexPath) -> Milestone { get }
    
    func load(completion: @escaping (Bool) -> Void)
    func add(item: Milestone, completion: @escaping ((IndexPath) -> Void))
    func update(item: Milestone, indexPath: IndexPath, completion: @escaping (IndexPath) -> Void)
    func delete(with milestoneNo: Int, completion: @escaping (IndexPath) -> Void)
}
