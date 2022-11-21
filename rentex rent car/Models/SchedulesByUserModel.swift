//
//  UserSchedules.swift
//  rentex rent car
//
//  Created by kenjimaeda on 19/11/22.
//

import Foundation

struct SchedulesByUserModel: Codable {
	let user: User;
	let cars: [CarsModel];
	
}

struct User: Codable  {
	let carId: Int
	let totalValue: String
	let startDate: String
	let endDate: String
	let userId: String
	
}

