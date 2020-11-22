//
//  IssueListNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/10.
//

import Foundation

class IssueListNetworkManager: NetworkManager, IssueListNetworkManaging {
    
    struct AddRequest: Codable {
        let issueTitle: String
        let issueContent: String
    }

    struct AddResponse: Codable {
        var success: Bool
        var newIssueNo: Int
    }
    
    static let listRequestURL = baseURL + "/api/issue/list"
    static let addRequestURL = baseURL + "/api/issue"
    
    func requestAdd(title: String, content: String, completion: @escaping (Result<IssueItem, NetworkError>) -> Void) {
        let issueAddRequest = AddRequest(issueTitle: title, issueContent: content)
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Self.addRequestURL)
        request.headers = baseHeader
        let json = try? JSONEncoder.custom.encode(issueAddRequest)
        request.body = json
        service.request(request: request) { [weak self] result in
            switch result {
            case .success(let data):
                guard let issueAddData = try? JSONDecoder.custom.decode(AddResponse.self, from: data),
                      let userData = self?.userData else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                let issue = Issue(issueNo: issueAddData.newIssueNo,
                                  issueTitle: title,
                                  issueContent: content,
                                  issueFlag: 1,
                                  issueDate: Date(),
                                  issueAuthorNo: userData.usserNo,
                                  issueAuthorName: userData.name)
                
                let issueItem = IssueItem(issue: issue, assignees: [], labels: [], milestone: nil)
                completion(.success(issueItem))
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
    
    func requestList(completion: @escaping (Result<[IssueItem], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.listRequestURL)
        request.headers = baseHeader
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let items = try? JSONDecoder.custom.decode([IssueItem].self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(items))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}
