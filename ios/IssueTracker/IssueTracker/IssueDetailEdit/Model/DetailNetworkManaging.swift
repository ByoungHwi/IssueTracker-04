//
//  DetailEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

protocol DetailNetworkManaging {
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void)
    func update(issueNo: Int, updateItems: [DetailEditCellData], completion: @escaping (Bool) -> Void)
}
