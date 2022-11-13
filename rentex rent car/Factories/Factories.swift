//
//  Factories.swift
//  rentex rent car
//
//  Created by kenjimaeda on 13/11/22.
//

import Foundation
import UIKit

func makeImg(_ stringImg: String) -> UIImageView  {
	let uiImg = UIImageView(image: UIImage(named: stringImg))
	uiImg.translatesAutoresizingMaskIntoConstraints = false
	uiImg.contentMode = .scaleAspectFit
	return uiImg
}

func makeLabel(_ stringLabel: String) -> UILabel {
	let uiLabel = UILabel()
	uiLabel.translatesAutoresizingMaskIntoConstraints = false
	uiLabel.text = stringLabel
	uiLabel.font = UIFont(name: "Inter-Regular.ttf", size: 18)
	uiLabel.textColor = UIColor(named: "gray300")
	return uiLabel
	
}


