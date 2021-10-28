//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isLikeButton: IsLikeButton!
    
    var likeButtonDelegate: LikeButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func toggleLikeButton(_ sender: IsLikeButton) {
        sender.updateIsLike()
        sender.updateButtonStatus()
        likeButtonDelegate?.reloadCurrentList()
    }
}
