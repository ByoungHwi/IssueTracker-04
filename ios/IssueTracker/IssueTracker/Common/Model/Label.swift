//
//  Label.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/22.
//

import Foundation

struct Label: Codable {
    var labelNo: Int
    var labelTitle, labelColor: String
    var labelDescription: String?
}
