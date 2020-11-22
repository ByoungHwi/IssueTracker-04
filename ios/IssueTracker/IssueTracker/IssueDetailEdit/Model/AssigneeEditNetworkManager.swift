//
//  AssigneeEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

class AssigneeEditNetworkManager: NetworkManager, DetailNetworkManaging {
    
    struct UserResponse: Codable {
        var success: Bool
        var userList: [User]
    }
    
    static let userListRequestURL = baseURL + "/api/userList"
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.userListRequestURL)
        request.headers = baseHeader
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(UserResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                let users = response.userList
                let datas = users.map { DetailEditCellData(type: .assignee(image: $0.userImg), itemId: $0.userNo, title: $0.userName) }
                completion(.success(datas))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func update(issueNo: Int, updateItems: [DetailEditCellData], completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
