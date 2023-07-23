//
//  HeaderView.swift
//  compositional Layout
//
//  Created by Mohamed Khaled on 23/07/2023.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
}
