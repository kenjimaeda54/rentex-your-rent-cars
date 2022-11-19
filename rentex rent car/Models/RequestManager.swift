//
//  RequestManager.swift
//  rentex rent car
//
//  Created by kenjimaeda on 18/11/22.
//

import Foundation

protocol CardDelegate {
	func didUpdateRequestCars(_ data: [CarsModel])
	func didFailWithErrorCar(_ error:Error)
}

protocol SchedulesDelegate {
	func didUpdateRequestSchedules(_ data: SchedulesByCars)
	func didFailWithErrorSchedules(_ error:Error)
}

struct RequestManager {
	
	var delegateCar: CardDelegate?
	var delegateSchedules: SchedulesDelegate?
	
	func fetchData(noSafeUrl: String,typeRequest: String? = "") {
		let urlSecure = noSafeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
		
		if let url = URL(string: urlSecure) {
			let session = URLSession(configuration: .default)
			
			let task = session.dataTask(with: url) { (data,response,error) in
				
				if error != nil {
					print(error)
				}
				
				guard let safeData = data else {return}
				
				let json = JSONDecoder()
				if typeRequest == "cars" {
					do {
						let request = try json.decode([CarsModel].self, from: safeData)
						delegateCar?.didUpdateRequestCars(request)
						
					}catch {
						delegateCar?.didFailWithErrorCar(error)
					}
					
				}else {
					
					do {
						let request = try json.decode(SchedulesByCars.self, from: safeData)
						delegateSchedules?.didUpdateRequestSchedules(request)
						
					}catch {
						delegateSchedules?.didFailWithErrorSchedules(error)
					}
					
				}
			
				
			}
			task.resume()
			
		}
		
	}
	
	
	
}
