//
//  LabelListNetworkManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol LabelListNetworkManaging {
    func loadLabelList(completion: @escaping (Result<[Label], NetworkError>) -> Void)
    func add(label: Label, completion: @escaping (Result<Int, NetworkError>) -> Void)
    func update(label: Label, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func delete(labelNo: Int, completion: @escaping (Result<Void, NetworkError>) -> Void)
}
