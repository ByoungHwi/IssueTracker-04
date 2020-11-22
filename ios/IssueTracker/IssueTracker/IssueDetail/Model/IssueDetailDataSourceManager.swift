//
//  IssueDetailDataSourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/04.
//

import Foundation

class IssueDetailDataSourceManager: IssueDetailDataManaging {
    
    private let networkManager: IssueDetailNetworkManaging
    
    init(networkManager: IssueDetailNetworkManaging) {
        self.networkManager = networkManager
    }
    
    subscript(indexPath: IndexPath) -> Comment? {
        return detailItem?.comments[indexPath.row]
    }
    
    var detailItem: IssueDetail?

    var commentCount: Int {
        detailItem?.comments.count ?? 0
    }
    
    func loadDetailItem(issueNo: Int, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void) {
        networkManager.requestIssueDetail(issueNo: issueNo) { [weak self] result in
            switch result {
            case .success(let item):
                self?.detailItem = item
                completion(result)
            case .failure(let error):
                completion(result)
                print(error.localizedDescription)
            }
        }
    }
    
    func addComment(comment: Comment, completion: @escaping (Bool) -> Void) {
        networkManager.addComment(comment: comment) { [weak self] result in
            switch result {
            case .success(let comment):
                self?.detailItem?.comments.append(comment)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func setIssueFlag(_ flag: Bool) {
        detailItem?.issue.isOpen = flag
    }
}
