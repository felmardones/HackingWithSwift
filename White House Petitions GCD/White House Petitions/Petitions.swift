//
//  Petitions.swift
//  White House Petitions
//
//  Created by Felipe on 7/4/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable{
    var results: [Petition]
}
