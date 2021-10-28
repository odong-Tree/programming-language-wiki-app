//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class IsLikeButton: UIButton {
    var languageIndex: Int?
    
    func updateButtonStatus() {
        guard let index = languageIndex else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        
        self.isSelected = language.isLike
        
        if isSelected {
            self.setImage(UIImage(systemName: "star.fill"), for: UIControl.State.normal)
        } else {
            self.setImage(UIImage(systemName: "star"), for: UIControl.State.normal)
        }
    }
    
    func updateIsLike() {
        guard let index = languageIndex else { return }
        
        ProgrammingLanguageInfoManager.shared.infoList[index].isLike = !ProgrammingLanguageInfoManager.shared.infoList[index].isLike
    }
}
