//
//  RequestManager.swift
//  rentex rent car
//
//  Created by kenjimaeda on 18/11/22.
//

import Foundation

protocol RequestDelegate {
	func didUpdateRequest(_ data: [CarsModel])
	func didFailWithError(_ error:Error)
}

struct RequestManager {
	
	var delegate: RequestDelegate?
	
	func fetchData(_ noSafeUrl: String) {
		let safeUrl = noSafeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
		
		if let url = URL(string: safeUrl) {
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: url) {[self](data, response, error) in
				 
				if error != nil {
					delegate?.didFailWithError(error!)
					return print(error)
				}
				
				if let safeData = data {
					
				   
					if let request = jsonParse(safeData) {
						delegate?.didUpdateRequest(request)
						
					}
					
				}
			
				
				
			}
			task.resume()
		}
		
	}
	
	func jsonParse(_ data: Data) -> [CarsModel]? {
		let decoder = JSONDecoder()
		do {
			//array ao invez de objeot e so usar []
			let response = try decoder.decode([CarsModel].self, from: data)
			return response
		}catch {
			delegate?.didFailWithError(error)
		  return nil
		}
		
	}
	
	
}
