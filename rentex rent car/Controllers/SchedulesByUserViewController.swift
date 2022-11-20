//
//  SchedulesByUserViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 20/11/22.
//

import UIKit

class SchedulesByUserViewController: UIViewController {
	
	//MARK: - vars
	var requestManger = RequestManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
	  
	  //MAKR: fazer a requeste e mudar o model schedles by user 
		
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

extension SchedulesByUserViewController: UITableViewDelegate,UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		<#code#>
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		<#code#>
	}
	
	
}
