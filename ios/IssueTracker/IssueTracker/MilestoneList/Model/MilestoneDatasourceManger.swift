//
//  MilestoneDatasourceManger.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import Foundation

class MilestoneDatasourceManager: MilestoneDataManaging {
    
    private let networkManager: MilestoneNetworkManaging
    var items: [Milestone] = []
    var itemCount: Int {
        items.count
    }
    
    subscript(indexPath: IndexPath) -> Milestone {
        items[indexPath.row]
    }
    
    init(networkManager: MilestoneNetworkManaging) {
        self.networkManager = networkManager
    }
    
    func load(completion: @escaping (Bool) -> Void) {
        networkManager.load { [weak self] result in
            switch result {
            case .success(let items):
                self?.items.append(contentsOf: items)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
                return
            }
        }
    }
    
    func add(item: Milestone, completion: @escaping ((IndexPath) -> Void)) {
        networkManager.add(milestone: item) { [weak self] result in
            switch result {
            case .success(let newMilestoneNo):
                var newItem = item
                newItem.milestoneNo = newMilestoneNo
                self?.items.append(newItem)
                guard let count = self?.items.count else { return }
                completion(IndexPath(row: count - 1, section: 0))
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func update(item: Milestone, indexPath: IndexPath, completion: @escaping (IndexPath) -> Void) {
        networkManager.update(milestone: item) { [weak self] result in
            switch result {
            case .success:
                self?.items[indexPath.row] = item
                completion(indexPath)
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func delete(with milestoneNo: Int, completion: @escaping (IndexPath) -> Void) {
        networkManager.delete(milestoneNo: milestoneNo) { [weak self] result in
            switch result {
            case .success:
                guard let index = (self?.items.firstIndex { $0.milestoneNo == milestoneNo }) else {
                    return
                }
                self?.items.remove(at: index)
                completion(IndexPath(row: index, section: 0))
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}
