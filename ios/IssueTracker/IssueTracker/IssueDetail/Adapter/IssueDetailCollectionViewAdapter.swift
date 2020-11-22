//
//  IssueDetailCollectionViewAdapter.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/04.
//

import UIKit

class IssueDetailCollectionViewAdapter: NSObject, UICollectionViewDataSource {
    
    var dataManager: IssueDetailDataManaging
    
    init(dataManager: IssueDetailDataManaging) {
        self.dataManager = dataManager
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataManager.commentCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = dataManager[indexPath],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: item)
        cell.cellWidth = collectionView.frame.width
        ImageLoader.shared.load(url: item.authorImg, to: cell.authorImageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let item = dataManager.detailItem,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IssueDetailCollectionViewHeader.identifier, for: indexPath) as? IssueDetailCollectionViewHeader else {
            return UICollectionReusableView()
        }
        ImageLoader.shared.load(url: item.detailInfo.authorImg, to: header.authorImageView)
        header.configure(with: item)
        header.viewWidth = collectionView.frame.width
        
        return header
    }
    
}
