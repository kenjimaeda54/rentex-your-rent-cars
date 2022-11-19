//
//  SchedulesByCars.swift
//  rentex rent car
//
//  Created by kenjimaeda on 12/11/22.
//

import Foundation

struct SchedulesByCars: Decodable {
	
	let id: Int
	let unavailableDates: [String]
	let carId: Int
}


