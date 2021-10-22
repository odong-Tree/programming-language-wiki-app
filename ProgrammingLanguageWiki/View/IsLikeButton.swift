//
//  IsLikeButton.swift
//  ProgrammingLanguageWiki
//
//  Created by 김동빈 on 2021/10/22.
//

import UIKit

class IsLikeButton: UIButton {
    func updateButtonStatus(index: Int?) {
        guard let index = index else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        
        self.isSelected = language.isLike
    }
    
    func updateIsLike(index: Int?) {
        guard let index = index else { return }
        
        ProgrammingLanguageInfoManager.shared.infoList[index].isLike = !ProgrammingLanguageInfoManager.shared.infoList[index].isLike
    }
}
