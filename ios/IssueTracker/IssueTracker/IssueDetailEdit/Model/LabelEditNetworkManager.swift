//
//  LabelEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

class LabelEditNetworkManager: NetworkManager, DetailNetworkManaging {
    
    struct LabelResponse: Codable {
        var success: Bool
        var labels: [Label]
    }
    
    struct LabelUpdateRequest: Codable {
        var issueNo: Int
        var labels: [Int]
    }

    struct UpdateResponse: Codable {
        var success: Bool
    }
    
    static let labelListRequestURL = baseURL + "/api/labelList"
    static let labelUpdateRequestURL = baseURL + "/api/ilrelation"
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.labelListRequestURL)
        request.headers = baseHeader
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(LabelResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                let labels = response.labels
                let datas = labels.map { DetailEditCellData(type: .label(color: $0.labelColor), itemId: $0.labelNo, title: $0.labelTitle) }
                completion(.success(datas))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(issueNo: Int, updateItems: [DetailEditCellData], completion: @escaping (Bool) -> Void) {
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Self.labelUpdateRequestURL)
        request.headers = baseHeader
        let labelNos = updateItems.map { $0.itemId }
        let updateRequest = LabelUpdateRequest(issueNo: issueNo, labels: labelNos)
        request.body = try? JSONEncoder.custom.encode(updateRequest)
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(UpdateResponse.self, from: data),
                      response.success else {
                    completion(false)
                    return
                }
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
