//
//  ResturanTableViewCell.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/13/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import UIKit

class ResturanTableViewCell: UITableViewCell {
    @IBOutlet weak var resturantImageView: UIImageView!
    
    @IBOutlet weak var resturantNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(resturant: Resturant) {
        resturantNameLabel.text = resturant.name
        resturantImageView.setImage(image: resturant.image)
    }

}
import SDWebImage

extension UIImageView {
    func setImage(image: String) {
        self.sd_setImage(with: URL.init(string: image), completed: nil)
    }
}
