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
	

	
	func populetedCell(_ schedules: SchedulesByUserModel) {
		let url = URL(string: schedules.cars[0].thumbNail)!
		
		DispatchQueue.global().async {
			
			if let data = try? Data(contentsOf: url) {
				
				DispatchQueue.main.async {
					
					self.imgCar.image = UIImage(data: data)
					self.labBrand.text = schedules.cars[0].brand
					self.labName.text  = schedules.cars[0].name
					self.labPriceDiary.text = "\(schedules.cars[0].rent.price)"
					self.imgType.image = UIImage(named:  schedules.cars[0].fuelType)
					self.labEndDate.text = schedules.user.startDate
					self.labStartDate.text = schedules.user.endDate
					self.labPriceTotal.text = schedules.user.totalValue
					
				}
				
			}
			
		}
		
	}
	
}
