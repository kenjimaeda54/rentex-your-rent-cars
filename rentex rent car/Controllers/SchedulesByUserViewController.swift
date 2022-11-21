//
//  SchedulesByUserViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 20/11/22.
//

import UIKit

class SchedulesByUserViewController: UIViewController {
  
	//MARK: - IBOutlet
	@IBOutlet weak var labTotalSchedules: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	//MARK: - vars
	var requestManger = RequestManager()
	var schedulesByUser: [SchedulesByUserModel] = []
	var userId: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		requestManger.delegateSchedulesByUser = self
		
		requestManger.fetchData(url: "http://localhost:3000/users/\(userId!)",typeRequest: "schedulesByUser")
	
		  
		tableView.register(UINib(nibName: "RentsByUserTableViewCell", bundle: nil), forCellReuseIdentifier: "rentByUserCell")
		
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if let navigation = navigationController?.navigationBar{
			makeNavigationController(color: "black", navigation: navigation)
		}
		
		let backButton = UIBarButtonItem()
		backButton.title = ""
		navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
		navigationController?.navigationBar.tintColor = .white
		
	}
	
	
	
	
	
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension SchedulesByUserViewController: UITableViewDelegate,UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return schedulesByUser.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "rentByUserCell", for: indexPath) as! RentsByUserTableViewCell
		let schedules = schedulesByUser[indexPath.row]
		cell.populetedCell(schedules)
		return cell
	}
	
	
}

//MARK: - SchedulesByUserDelegate

extension SchedulesByUserViewController: SchedulesByUserDelegate {
	func didUpdateRequestSchedulesByUser(_ data: [SchedulesByUserModel]) {
		DispatchQueue.main.async {
			self.schedulesByUser = data
			self.labTotalSchedules.text = "\(data.count)"
			self.tableView.reloadData()
		}
		
	}
	
	func didFailWithErrorSchedulesByUser(_ error: Error) {
		 print(error)
	}
	
	
	
}
