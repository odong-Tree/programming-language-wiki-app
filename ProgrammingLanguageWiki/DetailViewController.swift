//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var isLikeButton: UIButton!
    
    var languageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllData()
        configureAccessibility()
    }
    
    private func setAllData() {
        guard let index = languageIndex else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        
        nameLabel.text = language.name
        logoImageView.image = language.logoImage
        descriptionLabel.text = language.body
        updateLikeButton()
    }
    
    private func updateLikeButton() {
        guard let index = languageIndex else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        
        isLikeButton.isSelected = language.isLike
        isLikeButton.accessibilityHint = isLikeButton.isSelected ? "선택됨" : "즐겨찾기에 추가하기"
    }
    
    private func configureAccessibility() {
        guard let index = languageIndex else { return }
        let language = ProgrammingLanguageInfoManager.shared.infoList[index]
        
        backButton.accessibilityLabel = "뒤로 가기"
        backButton.accessibilityIdentifier = "DetailViewCtonroller.backButton"
        
        isLikeButton.accessibilityLabel = "즐겨찾기"
        isLikeButton.accessibilityIdentifier = "DetailViewController.isLikeButton"
        
        logoImageView.isAccessibilityElement = true
        logoImageView.accessibilityLabel = "\(language.name) 로고"
        logoImageView.accessibilityIdentifier = "DetailViewController.logoImageView"
        
        nameLabel.accessibilityIdentifier = "DetailViewController.nameLabel"
        descriptionLabel.accessibilityIdentifier = "DetailViewController.descriptionLabel"
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toggleLikeButton(_ sender: UIButton) {
        guard let index = languageIndex else { return }
        
        ProgrammingLanguageInfoManager.shared.infoList[index].isLike = !ProgrammingLanguageInfoManager.shared.infoList[index].isLike
        
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
