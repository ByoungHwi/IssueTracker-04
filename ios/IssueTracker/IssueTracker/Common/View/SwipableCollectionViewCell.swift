//
//  SwipableCollectionViewCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

@IBDesignable
class SwipableCollectionViewCell: UICollectionViewCell {
    
    var mainLeadingConstraint: NSLayoutConstraint?
    var mainView: UIView?
    var rightContainerView: UIView?
    var panGesture: UIPanGestureRecognizer?
    var rightContentWidth: CGFloat = 80.0
    var maximumSwipeWidth: CGFloat {
        rightContentWidth * 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        contentView.backgroundColor = .systemRed
        configureMainView()
        configureContainerView()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onGesture))
        panGesture.cancelsTouchesInView = false
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
        self.panGesture = panGesture
    }
    
    private func configureMainView() {
        let mainView = UIView()
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainLeadingConstraint = mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        let constraints = [
            mainLeadingConstraint ?? NSLayoutConstraint(),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        mainView.backgroundColor = .systemBackground
        self.mainView = mainView
    }
    
    private func configureContainerView() {
        let containerView = UIView()
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: mainView?.trailingAnchor ?? NSLayoutXAxisAnchor()),
            containerView.widthAnchor.constraint(equalToConstant: rightContentWidth),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
        containerView.backgroundColor = .systemRed
        self.rightContainerView = containerView
    }
    
    @objc func onGesture() {
        guard let gesture = panGesture,
              let leadingAnchor = mainLeadingConstraint else {
            return
        }
        if gesture.state == .ended {
       
            let velocity = gesture.velocity(in: mainView).x
            gestureDidFinish(velocity: velocity)
            gesture.setTranslation(.zero, in: mainView)
            return
        }
        
        var newConstant = leadingAnchor.constant + gesture.translation(in: mainView).x
        if newConstant > 0 {
            newConstant = 0
        }
        if abs(newConstant) > maximumSwipeWidth {
            newConstant = -maximumSwipeWidth
        }
        leadingAnchor.constant = newConstant
        panGesture?.setTranslation(.zero, in: mainView)
    }
    
    private func gestureDidFinish(velocity: CGFloat) {
        guard let leadingAnchor = mainLeadingConstraint else {
            return
        }
        
        let newConstant: CGFloat = velocity < 0 ? -rightContentWidth : 0.0
        
        leadingAnchor.constant = newConstant
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
}

extension SwipableCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gesture = panGesture else {
            return false
        }
        return abs((gesture.velocity(in: gestureRecognizer.view)).x) > abs((gesture.velocity(in: gestureRecognizer.view)).y)
    }
}
