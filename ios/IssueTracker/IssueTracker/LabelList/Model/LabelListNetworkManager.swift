//
//  LabelListNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/12.
//

import Foundation

class LabelListNetworkManager: NetworkManager, LabelListNetworkManaging {
    
    struct ResultResponse: Codable {
        let success: Bool
        let message: String?
        let labelNo: Int?
    }
    
    struct ListResponse: Codable {
        var success: Bool
        var labels: [Label]
    }
    
    static let labelListRequestURL = baseURL + "/api/labelList"
    static let labelModifyRequestUrl = baseURL + "/api/label"
    
    func loadLabelList(completion: @escaping (Result<[Label], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.labelListRequestURL)
        request.headers = baseHeader
    
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let responseData = try? JSONDecoder.custom.decode(ListResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(responseData.labels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func add(label: Label, completion: @escaping (Result<Int, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Self.labelModifyRequestUrl)
        request.headers = baseHeader
        request.body = try? JSONEncoder.custom.encode(label)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(ResultResponse.self, from: data),
                      let newLabelNo = response.labelNo else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(newLabelNo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(label: Label, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .put)
        request.url = URL(string: Self.labelModifyRequestUrl + "/\(label.labelNo)")
        request.headers = baseHeader
        request.body = try? JSONEncoder.custom.encode(label)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(ResultResponse.self, from: data),
                      response.success else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(labelNo: Int, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .delete)
        request.url = URL(string: Self.labelModifyRequestUrl + "/\(labelNo)")
        request.headers = baseHeader
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(ResultResponse.self, from: data),
                      response.success else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
