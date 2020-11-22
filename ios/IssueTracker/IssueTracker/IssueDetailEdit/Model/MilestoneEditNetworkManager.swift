//
//  MilestoneEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

class MilestoneEditNetworkManager: NetworkManager, DetailNetworkManaging {
    
    struct MilestoneResponse: Codable {
        var success: Bool
        var milestones: [Milestone]
    }
    
    static let milestoneRequestURL = baseURL + "/api/milestoneList"
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.milestoneRequestURL)
        request.headers = baseHeader
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(MilestoneResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                let milestones = response.milestones
                let datas = milestones.map { DetailEditCellData(type: .milestone, itemId: $0.milestoneNo ?? 0, title: $0.milestoneTitle ?? "") }
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
