//
//  OrderTableViewCell.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/25.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    @IBOutlet weak var sugerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
