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
    
    var programmingLanguage: ProgrammingLanguageInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllData()
        configureAccessibility()
    }
    
    private func setAllData() {
        guard let item = programmingLanguage else { return }
        nameLabel.text = item.name
        logoImageView.image = item.logoImage
        descriptionLabel.text = item.body
        updateLikeButton(item: item)
    }
    
    private func updateLikeButton(item: ProgrammingLanguageInfo) {
        isLikeButton.isSelected = item.isLike
        isLikeButton.accessibilityHint = isLikeButton.isSelected ? "선택됨" : "즐겨찾기에 추가하기"
    }
    
    private func programmingLanguageIndex() -> Int? {
        guard let programmingLanguage = self.programmingLanguage else { return nil }
        let indexPath = ProgrammingLanguageInfoManager.shared.infoList.firstIndex(of: programmingLanguage)
        return indexPath
    }
    
    private func configureAccessibility() {
        guard let item = programmingLanguage else { return }
        
        backButton.accessibilityLabel = "뒤로 가기"
        backButton.accessibilityIdentifier = "DetailViewCtonroller.backButton"
        
        isLikeButton.accessibilityLabel = "즐겨찾기"
        isLikeButton.accessibilityIdentifier = "DetailViewController.isLikeButton"
        
        logoImageView.isAccessibilityElement = true
        logoImageView.accessibilityLabel = "\(item.name) 로고"
        logoImageView.accessibilityIdentifier = "DetailViewController.logoImageView"
        
        nameLabel.accessibilityIdentifier = "DetailViewController.nameLabel"
        descriptionLabel.accessibilityIdentifier = "DetailViewController.descriptionLabel"
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
