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
        updateLikeButton()
    }
    
    private func updateLikeButton() {
        guard let index = languageIndex else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        
        isLikeButton.isSelected = language.isLike
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toggleLikeButton(_ sender: UIButton) {
        guard let index = languageIndex else {
            return
        }
        
        ProgrammingLanguageInfoManager.shared.infoList[index].isLike = !ProgrammingLanguageInfoManager.shared.infoList[index].isLike
        
        likeButtonDelegate?.reloadCurrentList()
        updateLikeButton()
    }
    
    @IBAction func moveToURLButton(_ sender: Any) {
        guard let index = languageIndex else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        guard let encodedURLString = language.wikiURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedURLString) else { return }
        
        UIApplication.shared.open(url)
    }
}
