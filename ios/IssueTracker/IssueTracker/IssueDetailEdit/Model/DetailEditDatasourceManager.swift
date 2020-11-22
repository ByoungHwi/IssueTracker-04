//
//  IssueDetailEditDatasourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

class DetailEditDatasourceManager: DetailEditDataManaging {
    
    var networkManager: DetailNetworkManaging
    var issueNo: Int
    
    init(networkManager: DetailNetworkManaging, issueNo: Int) {
        self.networkManager = networkManager
        self.issueNo = issueNo
    }
    
    var selectedItems: [DetailEditCellData] = []
    var unSelectedItems: [DetailEditCellData] = []
    
    subscript(indexPath: IndexPath) -> DetailEditCellData? {
        switch section(of: indexPath) {
        case .selected:
            return selectedItems[indexPath.row]
        case .unSelected:
            return unSelectedItems[indexPath.row]
        case .none:
            return nil
        }
    }
    
    var numberOfSections: Int {
        EditSection.allCases.count
    }
    
    func section(of indexPath: IndexPath) -> EditSection? {
        EditSection(rawValue: indexPath.section)
    }
    
    func headerTitle(of section: Int) -> String? {
        EditSection(rawValue: section)?.description
    }
    
    func numberOfRow(at section: Int) -> Int {
        switch EditSection(rawValue: section) {
        case .selected:
            return selectedItems.count
        case .unSelected:
            return unSelectedItems.count
        case .none:
            return 0
        }
    }
    
    func toggle(from indexPath: IndexPath) -> IndexPath? {
        switch section(of: indexPath) {
        case .selected:
            guard let item = self[indexPath],
                  let index = (selectedItems.firstIndex { $0.itemId == item.itemId }) else {
                return nil
            }
            selectedItems.remove(at: index)
            unSelectedItems.insert(item, at: 0)
            return IndexPath(row: 0, section: 1)
            
        case .unSelected:
            guard let item = self[indexPath],
                  let index = (unSelectedItems.firstIndex { $0.itemId == item.itemId }) else {
                return nil
            }
            unSelectedItems.remove(at: index)
            selectedItems.append(item)
            return IndexPath(row: selectedItems.count - 1, section: 0)
        case .none:
            return nil
        }
    }
   
    func loadItems(completion: @escaping (Bool) -> Void) {
        networkManager.loadData { [weak self] result in
            switch result {
            case .success(let datas):
                var unselected = datas
                self?.selectedItems.forEach { selected in
                    unselected = unselected.filter { $0.itemId != selected.itemId }
                }
                self?.unSelectedItems = unselected
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func updateItems(completion: @escaping ((Bool) -> Void)) {
        networkManager.update(issueNo: issueNo, updateItems: selectedItems) { isSuccess in
            completion(isSuccess)
        }
    }
}
