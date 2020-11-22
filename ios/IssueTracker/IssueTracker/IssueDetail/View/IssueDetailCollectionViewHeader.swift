//
//  IssueDetailCollectionViewHeader.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

class IssueDetailCollectionViewHeader: UICollectionReusableView {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var issueStatusButton: IssueStatusBadge!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var issueTitleLableHeightConstraint: NSLayoutConstraint!
    
    var viewWidth: CGFloat? {
        didSet {
            guard let viewWidth = viewWidth else {
                return
            }
            
            containerViewWidthConstraint.constant = viewWidth
            let sizeToFitIn = CGSize(width: viewWidth - 32, height: CGFloat(MAXFLOAT))
            let issueTitleLabelSize = issueTitleLabel.sizeThatFits(sizeToFitIn)
            issueTitleLableHeightConstraint.constant = issueTitleLabelSize.height
        }
    }
    
    func configure(with data: DetailHeaderData) {
        authorImageView.clipsToBounds = true
        authorImageView.layer.cornerRadius = authorImageView.frame.width/2
        authorNameLabel.text = data.issue.issueAuthorName
        issueTitleLabel.text = data.issue.issueTitle
        issueNumberLabel.text = "#\(data.issue.issueNo)"
        issueStatusButton.isOpen = data.issue.isOpen
    }
}
