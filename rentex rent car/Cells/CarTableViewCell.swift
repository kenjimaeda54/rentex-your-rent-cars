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
		
		
	}
	

	func populetedCell(_ cars: CarsModel) {
		
		let imgData  = URL(string: cars.thumbNail)!
		
		
		
		DispatchQueue.global().async {
			if let data = try? Data(contentsOf: imgData) {
				
				DispatchQueue.main.async {
					self.imgCar.image = UIImage(data: data)
					self.imgTypeFuel.image = UIImage(named: cars.fuelType)
					self.labModel.text = cars.name.capitalized
					self.labBrand.text = cars.brand.capitalized
					self.labDayValue.text = "R$\(cars.rent.price)"
					self.labDay.text = cars.rent.period
					
					
				}
				
			}
			
			
		}
		
	}
}
