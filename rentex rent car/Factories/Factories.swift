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


func makeNavigationController(color: String,navigation: UINavigationBar) {
	let apperance = UINavigationBarAppearance()
	apperance.configureWithOpaqueBackground()
	apperance.backgroundColor = UIColor(named: color)
	apperance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
	navigation.scrollEdgeAppearance = apperance
	navigation.standardAppearance = apperance
	
	
}

func makeButton(_ title: String) -> UIButton { 
	let button = UIButton()
	button.translatesAutoresizingMaskIntoConstraints = false
	button.backgroundColor = .clear
	button.setTitle(title, for: .normal)
	button.setTitleColor(UIColor(named: "gray300"), for: .normal)
	return button;
}
