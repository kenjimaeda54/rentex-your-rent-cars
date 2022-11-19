//
//  RequestManager.swift
//  rentex rent car
//
//  Created by kenjimaeda on 18/11/22.
//

import Foundation

protocol RequestDelegate {
	func didUpdateRequestCars(_ data: [CarsModel])
	func didFailWithError(_ error:Error)
}

struct RequestManager {
	
	var delegate: RequestDelegate?
	
	func fetchData(_ noSafeUrl: String) {
		let urlSecure = noSafeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
		
		if let url = URL(string: urlSecure) {
			let session = URLSession(configuration: .default)
			
			let task = session.dataTask(with: url) { (data,response,error) in
				
				if error != nil {
					delegate?.didFailWithError(error!)
					print(error)
				}
				
				if let safeData = data {
				
					if let cars = jsonParse(safeData) as [CarsModel]? {
						delegate?.didUpdateRequestCars(cars)
						
					}
					
				}
				
			}
			task.resume()
			
		}
		
	}
	
	func jsonParse<T: Decodable>(_ data: Data) -> [T]? {
		let json = JSONDecoder()
		do {
			let request = try json.decode([T].self, from: data)
			return request
			
		}catch {
			delegate?.didFailWithError(error)
			return nil
		}
		
	}
	
}
