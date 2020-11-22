//
//  LabelDataManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol LabelDataManaging {
    var itemCount: Int { get }
    subscript(indexPath: IndexPath) -> Label { get }
    
    func load(complete: @escaping (Bool) -> Void)
    func add(label: Label, completion: @escaping ((IndexPath) -> Void))
    func update(label: Label, indexPath: IndexPath, completion: @escaping ((IndexPath) -> Void))
    func delete(with labelNo: Int, completion: @escaping ((IndexPath) -> Void))
}
