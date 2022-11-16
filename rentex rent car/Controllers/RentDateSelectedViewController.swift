//
//  RentDateSelectedViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 14/11/22.
//

import UIKit
import SwiftDate
import FSCalendar

//implementado o fscalendar protocol
//https://github.com/WenchaoD/FSCalendar

//https://www.youtube.com/watch?v=FipNDF7g9tE
class RentDateSelectedViewController: UIViewController {
	
	
	//MARK: - IBOUTLET
	@IBOutlet weak var dateRentSelcet: UIDatePicker!
	@IBOutlet weak var viewFinalDate: UIView!
	@IBOutlet weak var viewInitalDate: UIView!
	@IBOutlet weak var fsCalendar: FSCalendar!
	
	//MARK: - Vars
	var carId: String?
	let carUnavailableDates: [SchedulesByCars] = MockData().schedulesByCar
	var orderDate: [DateInRegion]!
	var dateSelected: [Date] = []
	
	
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
			
			orderDate = DateInRegion.sortedByNewest(list: listDate)
			
			if let navigation = navigationController?.navigationBar{
				makeNavigationController(color: "black", navigation: navigation)
			}
			
		  //MARK: - FScalendar
			fsCalendar.allowsMultipleSelection = true
			fsCalendar.appearance.titleFont = UIFont(name: "Inter-Regular", size: 15)
			fsCalendar.appearance.headerTitleFont =  UIFont(name: "Archivo-SemiBold", size: 20)
			fsCalendar.appearance.headerTitleColor = UIColor(named: "black")
			fsCalendar.appearance.caseOptions = [.headerUsesCapitalized,.weekdayUsesUpperCase]
			fsCalendar.appearance.weekdayFont = UIFont(name: "Archivo-SemiBold", size: 10)
			fsCalendar.appearance.weekdayTextColor = UIColor(named: "gray200")
			fsCalendar.appearance.borderRadius = 0
			fsCalendar.appearance.selectionColor = UIColor(named: "red50")
			
			
		}
		
	}
	
	@IBAction func handleSelectDatePicker(_ sender: UIDatePicker) {
	}
	
	
	@IBAction func handleConfirmRent(_ sender: UIButton) {
	}
 
	func dateAvailabel(_ date: Date) -> Bool {
		
		
		let haveDate = orderDate.first {
			let dateRegionFormater = "\($0.date.day)/\($0.date.month)"
			let date = "\(date.day)/\(date.month)"
			return dateRegionFormater == date
		}
			
		return haveDate != nil ? true : false
		
	}
	
	
}

//https://www.youtube.com/watch?v=FipNDF7g9tE
//MARK: -FSCalendarDelegate,FSCalendarDataSource
extension RentDateSelectedViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
	
	func minimumDate(for calendar: FSCalendar) -> Date {
		return orderDate[orderDate.count - 1].date
	}
	
	func maximumDate(for calendar: FSCalendar) -> Date {
		return orderDate[0].date
	}

	//dentro de cada mês existem dias que não estão disponíveis,
  //na lógica abaixo  impedira de selecionar esses dias
	func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
	
	  return dateAvailabel(date)
	}
	
	func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
		
	
		return dateAvailabel(date) ? nil : UIColor(named: "gray200")
	}
	

	
}
