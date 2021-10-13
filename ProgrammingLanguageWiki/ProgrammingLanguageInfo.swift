//
//  ProgrammingLanguageInfo.swift
//  ProgrammingLanguageWiki
//
//  Created by 김동빈 on 2021/10/12.
//

import UIKit

struct ProgrammingLanguageInfo: Decodable {
    let name: String
    let wikiURL: String
    var isLike: Bool
    let body: String
    var logoImage: UIImage? {
        return UIImage(named: self.name)
    }
    
    enum CodingKeys: CodingKey {
        case name
        case wikiURL
        case isLike
        case body
    }
}


