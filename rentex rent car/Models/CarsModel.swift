//
//  CarModel.swift
//  rentex rent car
//
//  Created by kenjimaeda on 12/11/22.
//

import Foundation


struct CarsModel: Decodable {
	
	let id: Int
	let brand: String
	let name: String
	let about: String
	let rent: Rent
	let fuelType: String
	let thumbNail: String
	let accessories: [Acessories]
	let photos: [String]
	
}


struct Rent: Decodable {
	
	let period: String
	let price: Double
	
}


struct Acessories: Decodable {
	
 let type: String
	let name: String
		
}


