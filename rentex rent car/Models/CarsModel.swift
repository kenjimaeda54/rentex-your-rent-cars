//
//  CarModel.swift
//  rentex rent car
//
//  Created by kenjimaeda on 12/11/22.
//

import Foundation

struct CarsModel {
	
	let id: String
	let brand: String
	let name: String
	let about: String
	let rent: Rent
	let fuelType: String
	let thumbNail: String
	let accessories: [Acessories]
	
}

struct Rent {
	
	let period: String
	let price: Double
	
}


struct Acessories {
	
 let type: String
	let name: String
		
}


