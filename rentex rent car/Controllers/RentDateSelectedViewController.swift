//
//  RentDateSelectedViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 14/11/22.
//

import UIKit
import SwiftDate

class RentDateSelectedViewController: UIViewController {

	
	//MARK: - IBOUTLET
	@IBOutlet weak var dateRentSelcet: UIDatePicker!
	@IBOutlet weak var viewFinalDate: UIView!
	@IBOutlet weak var viewInitalDate: UIView!
  
	
	//MARK: - Vars
	var carId: String?
	let carUnavailableDates: [SchedulesByCars] = MockData().schedulesByCar
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewWillAppear(_ animated: Bool) {
		  super.viewWillAppear(animated)
		 
		if let id = carId {
			let filterCar = carUnavailableDates.first { $0.id == id}
			guard let car = filterCar else {return}
			
			//https://cocoacasts.com/swift-fundamentals-how-to-convert-a-string-to-a-date-in-swift
		
			//https://cocoapods.org/pods/SwiftDate
			let listDate: [DateInRegion] =  car.unavailableDates.map {
				return $0.toDate("yyyy-MM-dd")!
			}
		    
			let orderDate = DateInRegion.sortedByNewest(list: listDate)
		  
		
			dateRentSelcet.minimumDate = orderDate[orderDate.count - 1].date
			dateRentSelcet.maximumDate = orderDate[0].date
	    
			dateRentSelcet.
			
		}
		
		
		if let navigation = navigationController?.navigationBar{
			makeNavigationController(color: "black", navigation: navigation)
		}
		
	}
    
	@IBAction func handleSelectDatePicker(_ sender: UIDatePicker) {
	}
	
 
	@IBAction func handleConfirmRent(_ sender: UIButton) {
	}
	
}



