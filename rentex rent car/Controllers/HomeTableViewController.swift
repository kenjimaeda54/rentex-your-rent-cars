//
//  HomeTableViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 12/11/22.
//

import UIKit

class HomeTableViewController: UITableViewController {
	
	//MARK: - Vars
	let backgroundNavigationBar = UIView()
	var cars: [CarsModel] = []
	var managerModels = RequestManager()
	let labQuantityCars = makeLabel("Total de 0")
	let buttonRentByUser = makeButton("Alugados")
	let defaults = UserDefaults.standard
	var userId: String?

	override func viewDidLoad() {
		super.viewDidLoad()
		managerModels.delegateCar = self
		managerModels.fetchData(url:"http://localhost:3000/cars",  typeRequest: "cars")
		
		//registrar .xib essencial
		//nome identico da classe
		tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil),forCellReuseIdentifier: "cellCars")
		
		
		
	
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		prepareViewNavigation()
		
		let haveId = defaults.object(forKey: "userId") as? String
		buttonRentByUser.isHidden = haveId != nil ? false : true
		
		if haveId != nil {
			 userId = haveId
		}
		
		//para lightContentRefletir precisa o estilo ser .black
		navigationController?.navigationBar.barStyle = .black
		
		if let navigation = navigationController?.navigationBar{
			makeNavigationController(color: "black", navigation: navigation)
		}
	}
	

	
	//adicionar view ao navigation bar
	func prepareViewNavigation() {
		let imgLogotipo = makeImg("logotipo")
		
		
		buttonRentByUser.addTarget(self, action: #selector(goScreenRentCars), for: .touchUpInside)
		
		backgroundNavigationBar.addSubview(imgLogotipo)
		backgroundNavigationBar.addSubview(labQuantityCars)
		backgroundNavigationBar.addSubview(buttonRentByUser)
		backgroundNavigationBar.translatesAutoresizingMaskIntoConstraints = false
				
		navigationController?.navigationBar.addSubview(backgroundNavigationBar)
		
		
		if let navigationView = navigationController?.navigationBar {
			NSLayoutConstraint.activate([
				
				
				backgroundNavigationBar.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: 0),
				backgroundNavigationBar.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor,constant: 0),
				backgroundNavigationBar.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor,constant: 0),
				backgroundNavigationBar.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 0),
				
				
				imgLogotipo.leadingAnchor.constraint(equalTo: backgroundNavigationBar.leadingAnchor, constant: 18),
				imgLogotipo.bottomAnchor.constraint(equalTo: backgroundNavigationBar.bottomAnchor,constant: -32),
				imgLogotipo.trailingAnchor.constraint(lessThanOrEqualTo: labQuantityCars.leadingAnchor, constant: 80),
				imgLogotipo.topAnchor.constraint(equalTo: backgroundNavigationBar.topAnchor,constant: 20),
				
				labQuantityCars.trailingAnchor.constraint(equalTo: backgroundNavigationBar.trailingAnchor, constant: -18),
				labQuantityCars.bottomAnchor.constraint(equalTo: backgroundNavigationBar.bottomAnchor,constant: -32),
				labQuantityCars.topAnchor.constraint(equalTo: backgroundNavigationBar.topAnchor,constant: 20),
				
				
				buttonRentByUser.trailingAnchor.constraint(equalTo: labQuantityCars.trailingAnchor, constant: 0),
				buttonRentByUser.bottomAnchor.constraint(equalTo: labQuantityCars.topAnchor, constant: -2),
				buttonRentByUser.topAnchor.constraint(equalTo: backgroundNavigationBar.topAnchor, constant: 10)
				
				
			])
			
		}
		
		
	}
	
	
	@objc func goScreenRentCars() {
		 performSegue(withIdentifier:  "rentByUserSegue", sender: nil)
	}
	
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		backgroundNavigationBar.removeFromSuperview()
	}
	
	
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cars.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellCars", for: indexPath) as! CarTableViewCell
		let car = cars[indexPath.row]
		cell.populetedCell(car)
		labQuantityCars.text = "Total de \(cars.count) carros"
		//dessativar selectoin style
		cell.selectionStyle = .none
		
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let carsSelected = cars[indexPath.row]
		performSegue(withIdentifier: "detailsSegue", sender: carsSelected)
	}
	
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "detailsSegue" {
			let vc = segue.destination as! DetailsCarViewController
			vc.car = sender as? CarsModel
		}
		
		if segue.identifier == "rentByUserSegue" {
			let vc = segue.destination as! SchedulesByUserViewController
			vc.userId = userId
		}
		
	}
	
	
}

//MARk: - RequestDelegate
extension HomeTableViewController:  CardDelegate {
	func didUpdateRequestCars(_ data: [CarsModel]) {
		cars = data
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
		
		
	}
	
	
	func didFailWithErrorCar(_ error: Error) {
		print(error)
	}
	
	
}
