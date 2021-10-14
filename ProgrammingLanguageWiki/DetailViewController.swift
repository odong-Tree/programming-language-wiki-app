//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var languageTitleLabel: UILabel!
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageDescriptionLabel: UILabel!
    @IBOutlet weak var isLikeButton: UIButton!
    
    var programmingLanguage: ProgrammingLanguageInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllData()
    }
    
    private func setAllData() {
        guard let item = programmingLanguage else { return }
        languageTitleLabel.text = item.name
        languageImageView.image = item.logoImage
        languageDescriptionLabel.text = item.body
        updateLikeButton(item: item)
    }
    
    private func updateLikeButton(item: ProgrammingLanguageInfo) {
        isLikeButton.isSelected = item.isLike
    }
    
    private func programmingLanguageIndex() -> Int? {
        guard let programmingLanguage = self.programmingLanguage else { return nil }
        let indexPath = ProgrammingLanguageInfoManager.shared.infoList.firstIndex(of: programmingLanguage)
        return indexPath
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toggleLikeButton(_ sender: UIButton) {
        guard let index = programmingLanguageIndex() else { return }
        
        ProgrammingLanguageInfoManager.shared.infoList[index].isLike = !ProgrammingLanguageInfoManager.shared.infoList[index].isLike
        
        updateLikeButton(item: ProgrammingLanguageInfoManager.shared.infoList[index])
    }
    
    @IBAction func moveToURLButton(_ sender: Any) {
        guard let urlString = programmingLanguage?.wikiURL else { return }
        guard let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedURLString) else { return }
        
        UIApplication.shared.open(url)
    }
}
