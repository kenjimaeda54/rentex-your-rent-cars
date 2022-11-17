//
//  ReserveCollectionViewCell.swift
//  rentex rent car
//
//  Created by kenjimaeda on 16/11/22.
//

import UIKit

class ReserveCollectionViewCell: UICollectionViewCell {
   
	
	@IBOutlet weak var labFeatureIcon: UIImageView!
	@IBOutlet weak var labTitle: UILabel!
	
	func populetedCell(_ accessories: Acessories) {
		labTitle.text = accessories.name
		labFeatureIcon.image = UIImage(named: accessories.type)
		
	}
	
}
