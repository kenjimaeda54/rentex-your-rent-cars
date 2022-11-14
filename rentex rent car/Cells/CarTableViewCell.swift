//
//  CarTableViewCell.swift
//  rentex rent car
//
//  Created by kenjimaeda on 12/11/22.
//

import UIKit

class CarTableViewCell: UITableViewCell {
	
	@IBOutlet weak var imgCar: UIImageView!
	@IBOutlet weak var imgTypeFuel: UIImageView!
	@IBOutlet weak var labModel: UILabel!
	@IBOutlet weak var labDayValue: UILabel!
	@IBOutlet weak var labDay: UILabel!
	@IBOutlet weak var labBrand: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	
	func populetedCell(_ cars: CarsModel) {
		imgCar.image = UIImage(named:cars.thumbNail)
		imgTypeFuel.image = UIImage(named: cars.fuelType)
		labModel.text = cars.name
		labBrand.text = cars.brand
		labDayValue.text = "R$\(cars.rent.price)"
		labDay.text = cars.rent.period
	}
	
}
