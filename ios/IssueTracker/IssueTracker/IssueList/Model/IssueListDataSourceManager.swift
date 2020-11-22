//
//  IssueListDataSourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/01.
//

import Foundation

class IssueListDataSourceManager: IssueListDataManaging {
    
    var items: [IssueItem] = []
    var networkManager: IssueListNetworkManaging
    var itemCount: Int {
        items.count
    }
    
    init(networkManager: IssueListNetworkManaging) {
        self.networkManager = networkManager
    }
    
    subscript(indexPath: IndexPath) -> IssueItem {
        items[indexPath.row]
    }
    
    subscript(indexPaths: [IndexPath]) -> [IssueItem] {
        indexPaths.map { self[$0] }
    }
    
    func add(title: String, content: String, completion: @escaping (Bool) -> Void) {
        networkManager.requestAdd(title: title, content: content) { [weak self] result in
            switch result {
            case .success(let newItem):
                self?.items.insert(newItem, at: 0)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
            completion(true)
        }
    }
    
    func loadIssueList(completion: @escaping  (Bool) -> Void) {
        networkManager.requestList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let issues):
                    self?.items = issues
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    func deleteIssue(by issueNo: Int, completion: (IndexPath) -> Void) {
        guard let index = (items.firstIndex { $0.issueNo == issueNo}) else {
            return
        }
        items.remove(at: index)
        let indexPath = IndexPath(row: index, section: 0)
        completion(indexPath)
    }
    
    func deleteIssues(indexPaths: [IndexPath]) {
        let deleteIndex = indexPaths.map { $0.row }
        items = items.indices
            .filter { !deleteIndex.contains($0) }
            .map { items[$0] }
    }
    
    func closeIssue(indexPath: IndexPath) {
        //API 미완성
    }

    func closeIssues(indexPaths: [IndexPath]) {
        //API 미완성
    }
    
}
