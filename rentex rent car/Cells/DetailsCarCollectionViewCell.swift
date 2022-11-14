//
//  DetailsCarCollectionViewCell.swift
//  rentex rent car
//
//  Created by kenjimaeda on 13/11/22.
//

import UIKit

class DetailsCarCollectionViewCell: UICollectionViewCell {
	
	
	@IBOutlet weak var labTitle: UILabel!
	
	@IBOutlet weak var labFeatureIcon: UIImageView!
	

	
	func populetedCell(_ accessories: Acessories) {
		labTitle.text = accessories.name
		labFeatureIcon.image = UIImage(named: accessories.type)
		
	}
	
}

