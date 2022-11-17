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
	@IBOutlet weak var btnConfirm: UIButton!
	@IBOutlet weak var labReferenceFinalDate: UILabel!
	@IBOutlet weak var labReferenceInitialDate: UILabel!
	@IBOutlet weak var dateRentSelect: UIDatePicker!
	@IBOutlet weak var viewFinalDate: UIView!
	@IBOutlet weak var viewInitalDate: UIView!
	@IBOutlet weak var fsCalendar: FSCalendar!
	
	//MARK: - Vars
	var carId: String?
	let carUnavailableDates: [SchedulesByCars] = MockData().schedulesByCar
	var orderDate: [DateInRegion]!
	var dateSelected: [String] = []
	let labelFinalDate = makeLabel("")
	let labelInitialDate = makeLabel("")
	
	
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
			
			//MARK: - FScalendar aparence
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
	
	
	@IBAction func handleConfirmRent(_ sender: UIButton) {
		
		returnCollectionDateSelected { collectionDate in
			var initialDate: String
			var finalDate: String
			
			if collectionDate.count > 0 {
				initialDate = collectionDate[collectionDate.count  - 1].date.toFormat("yyyy/MM/dd")
				finalDate = collectionDate[0].date.toFormat("yyyy/MM/dd")
				
			}else {
				initialDate = collectionDate[0].date.toFormat("yyyy/MM/dd")
				finalDate = collectionDate[0].date.toFormat("yyyy/MM/dd")
			}
			
			let dateRangeSelectedRent: [String:String] = ["initialDate":initialDate,"finalDate": finalDate    ]
			self.performSegue(withIdentifier: "reserveSegue", sender: dateRangeSelectedRent)
			
		}
		
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "reserveSegue" {
			let vc = segue.destination as! ReserveCarViewController
			vc.dateRent = sender as? [String:String]
		}
	}
	
	
	func dateAvailabel(_ date: Date) -> Bool {
		let haveDate = orderDate.first {
			let dateRegionFormater = "\($0.date.day)/\($0.date.month)"
			let date = "\(date.day)/\(date.month)"
			return dateRegionFormater == date
		}
		
		return haveDate != nil ? true : false
		
	}
	
	func returnCollectionDateSelected(completion: @escaping([DateInRegion]) -> Void  ) {
		
		let collectionDate = dateSelected.map {
			$0.toDate()!
		}
		
		let sorted = DateInRegion.sortedByNewest(list: collectionDate)
		
		completion(sorted)
		
		
	}
	
	func makeLabelSelected(_ date: String) {
		
		viewInitalDate.isHidden = true
		viewFinalDate.isHidden = true
		labelInitialDate.isHidden = false
		labelFinalDate.isHidden = false
		labelInitialDate.text = dateSelected[0]
		
		
		
		returnCollectionDateSelected {
			//sortear para pegar a data mais alta
			//MARK: - fazer um foreach e comparar as datas dentro
			let formatSorted = $0[0].toFormat("yyyy/MM/dd")
			self.labelFinalDate.text = formatSorted
		}
		
		
		self.view.addSubview(labelInitialDate)
		self.view.addSubview(labelFinalDate)
		
		NSLayoutConstraint.activate([
			
			labelInitialDate.leadingAnchor.constraint(equalTo: labReferenceInitialDate.leadingAnchor, constant: 0),
			labelInitialDate.widthAnchor.constraint(equalToConstant: 100),
			labelInitialDate.topAnchor.constraint(equalTo: labReferenceInitialDate.bottomAnchor, constant: 0),
			labelInitialDate.heightAnchor.constraint(equalToConstant: 50),
			
			labelFinalDate.leadingAnchor.constraint(equalTo: labReferenceFinalDate.leadingAnchor, constant: 0),
			labelFinalDate.widthAnchor.constraint(equalToConstant: 100),
			labelFinalDate.topAnchor.constraint(equalTo: labReferenceFinalDate.bottomAnchor, constant: 0),
			labelFinalDate.heightAnchor.constraint(equalToConstant: 50),
			
			
		])
		
		
	}
	
	func makeLabelDeSelected(_ date: String)  {
		
		if dateSelected.count == 0 {
			labelInitialDate.isHidden = true
			labelFinalDate.isHidden = true
			viewFinalDate.isHidden = false
			viewInitalDate.isHidden = false
			return
			
		}
		
		returnCollectionDateSelected{
			//sortear para pegar a data mais alta
			//MARK: - fazer um foreach e comparar as datas dentro
			let formatSorted = $0[0].toFormat("yyyy/MM/dd")
			self.labelFinalDate.text = formatSorted
		}
		
		
	}
	
	
	
}

//https://www.youtube.com/watch?v=FipNDF7g9tE
//MARK: -FSCalendarDelegate,FSCalendarDataSource
extension RentDateSelectedViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
	
	//MARK: - Min e Max
	func minimumDate(for calendar: FSCalendar) -> Date {
		return orderDate[orderDate.count - 1].date
	}
	
	func maximumDate(for calendar: FSCalendar) -> Date {
		return orderDate[0].date
	}
	
	//dentro de cada mês existem dias que não estão disponíveis,
	//na lógica abaixo  impedira de selecionar esses dias
	//MARK: - Apagar dias não disponíveis para aluguel
	func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
		return dateAvailabel(date)
	}
	
	func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
		return dateAvailabel(date) ? nil : UIColor(named: "gray200")
	}
	
	
	//MARK: - DidSelect and Deselect
	
	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		let dateFormat = date.toFormat("yyyy/MM/dd")

		
		dateSelected.append(dateFormat)
		makeLabelSelected(dateFormat)
   
		if dateSelected.count > 0 {
			btnConfirm.isEnabled = true
		}

	}
	
	func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
		let dateFormat = date.toFormat("yyyy/MM/dd")
		
		let indexRemove = dateSelected.firstIndex(where: {
			return $0 == dateFormat
		})
		
		if let index  = indexRemove {
			dateSelected.remove(at: index)
		}
		
		//essencial remover a subview antes de atualizar ela
		self.view.willRemoveSubview(labelFinalDate)
		makeLabelDeSelected(dateFormat)
		
		//desativar button
		if dateSelected.count == 0 {
			btnConfirm.isEnabled = false
		}
		
	}
	
	
}
