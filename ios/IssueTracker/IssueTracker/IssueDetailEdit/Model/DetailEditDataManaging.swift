//
//  DetailEditDataManaging.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

protocol DetailEditDataManaging {
    var issueNo: Int { get }
    var selectedItems: [DetailEditCellData] { get set }
    var unSelectedItems: [DetailEditCellData] { get set }
    var numberOfSections: Int { get }
    
    subscript(indexPath: IndexPath) -> DetailEditCellData? { get }
    
    func section(of indexPath: IndexPath) -> EditSection?
    
    func headerTitle(of section: Int) -> String?
    
    func numberOfRow(at section: Int) -> Int
    
    func toggle(from indexPath: IndexPath) -> IndexPath?
   
    func loadItems(completion: @escaping (Bool) -> Void)
    
    func updateItems(completion: @escaping ((Bool) -> Void))
}
