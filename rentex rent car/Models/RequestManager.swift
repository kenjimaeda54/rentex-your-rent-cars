//
//  RequestManager.swift
//  rentex rent car
//
//  Created by kenjimaeda on 18/11/22.
//

import Foundation
import Alamofire

protocol CardDelegate {
	func didUpdateRequestCars(_ data: [CarsModel])
	func didFailWithErrorCar(_ error:Error)
}

protocol SchedulesDelegate {
	func didUpdateRequestSchedules(_ data: SchedulesByCarsModel)
	func didFailWithErrorSchedules(_ error:Error)
}

protocol PostDelegate {
	
	func didFailWithErrorPost(_ error: String)
	func shouldReturnWithSucess(_ sucess: Bool)
	
}

protocol SchedulesByUser {
	func didUpdateRequestSchedulesByUser(_ data: [SchedulesByUserModel])
	func didFailWithErrorSchedulesByUser(_ error:Error)
	
}

struct RequestManager {
	
	var delegateCar: CardDelegate?
	var delegateSchedules: SchedulesDelegate?
	var delegatePost: PostDelegate?
	var delegateSchedulesByUser: SchedulesByUser?
	
	func fetchData(url: String,typeRequest: String? = "") {
		
		AF.request(url).response { response in
			
			if let error =  response.error {
				print(error)
				return
			}
			
			if typeRequest == "cars" {
				
				if let data = response.data {
					do {
						let data = try JSONDecoder().decode([CarsModel].self, from: data)
						delegateCar?.didUpdateRequestCars(data)
					}catch{
						delegateCar?.didFailWithErrorCar(error)
					}
				}
				return
			}
			
			
			
			if typeRequest == "schedulesByUser" {
				
				if let data = response.data {
					do {
						let data = try JSONDecoder().decode([SchedulesByUserModel].self, from: data)
						delegateSchedulesByUser?.didUpdateRequestSchedulesByUser(data)
					}catch{
						delegateSchedulesByUser?.didFailWithErrorSchedulesByUser(error)
					}
				}
				return
			}
			
			if let data = response.data {
				do {
					let data = try JSONDecoder().decode(SchedulesByCarsModel.self, from: data)
					delegateSchedules?.didUpdateRequestSchedules(data)
				}catch{
					delegateSchedules?.didFailWithErrorSchedules(error)
				}
			}
		}
	}
	
	func postData(parameters: [String:Any],url: String) {
		
		AF.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default).validate(statusCode: 200..<299).responseData {response  in
			
			switch response.result {
			case .failure(let error):
				print(error)
				delegatePost?.didFailWithErrorPost("Não pode alugar este carro, porque  está  na sua lista de  alugados")
			case .success(let data):
				print(data)
				delegatePost?.shouldReturnWithSucess(true)
			}
			
		}
	}
	
}
