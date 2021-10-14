//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

struct ProgrammingLanguageInfo: Decodable, Equatable {
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


