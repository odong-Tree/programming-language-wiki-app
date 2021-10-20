//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import Foundation
import UIKit

class ProgrammingLanguageInfoManager {
    static let shared = ProgrammingLanguageInfoManager()
    var infoList: [ProgrammingLanguageInfo] = []
    
    private init() {
        decodeLanguageInfoList()
    }
    
    private func decodeLanguageInfoList() {
        guard let dataAsset = NSDataAsset(name: "ProgrammingLanguages") else { return }
        
        do {
            infoList = try JSONDecoder().decode([ProgrammingLanguageInfo].self, from: dataAsset.data)
        } catch {
            return
        }
    }
    
    func filteredList(isLikeSegment: Bool) -> [ProgrammingLanguageInfo] {
        let list = infoList.filter { item in
            return !isLikeSegment || item.isLike
        }
        
        return list
    }
}
