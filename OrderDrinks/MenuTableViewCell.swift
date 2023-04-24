//
//  MenuTableViewCell.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/23.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var menuName: UILabel!
    
    @IBOutlet weak var menuDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
