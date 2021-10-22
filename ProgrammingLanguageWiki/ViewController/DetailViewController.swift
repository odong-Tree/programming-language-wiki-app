//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var languageTitleLabel: UILabel!
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageDescriptionLabel: UILabel!
    @IBOutlet weak var isLikeButton: IsLikeButton!
    
    var languageIndex: Int?
    var likeButtonDelegate: LikeButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllData()
    }
    
    private func setAllData() {
        guard let index = languageIndex else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        
        languageTitleLabel.text = language.name
        languageImageView.image = language.logoImage
        languageDescriptionLabel.text = language.body
        isLikeButton.updateButtonStatus(index: languageIndex)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toggleLikeButton(_ sender: IsLikeButton) {
        sender.updateIsLike(index: languageIndex)
        sender.updateButtonStatus(index: languageIndex)
        likeButtonDelegate?.reloadCurrentList()
    }
    
    @IBAction func moveToURLButton(_ sender: Any) {
        guard let index = languageIndex else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        guard let encodedURLString = language.wikiURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedURLString) else { return }
        
        UIApplication.shared.open(url)
    }
}
