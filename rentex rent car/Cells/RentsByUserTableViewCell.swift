//
//  RentsByUserTableViewCell.swift
//  rentex rent car
//
//  Created by kenjimaeda on 20/11/22.
//

import UIKit

class RentsByUserTableViewCell: UITableViewCell {

	@IBOutlet weak var imgCar: UIImageView!
	@IBOutlet weak var labPriceTotal: UILabel!
	@IBOutlet weak var labEndDate: UILabel!
	@IBOutlet weak var labStartDate: UILabel!
	@IBOutlet weak var imgType: UIImageView!
	@IBOutlet weak var labPriceDiary: UILabel!
	@IBOutlet weak var labName: UILabel!
	@IBOutlet weak var labBrand: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
