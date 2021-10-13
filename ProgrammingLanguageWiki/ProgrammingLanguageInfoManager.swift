//
//  ProgrammingLanguageInfoManager.swift
//  ProgrammingLanguageWiki
//
//  Created by 김동빈 on 2021/10/12.
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
}
