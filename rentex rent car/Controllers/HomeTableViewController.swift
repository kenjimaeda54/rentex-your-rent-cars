//
//  HomeTableViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 12/11/22.
//

import UIKit

class HomeTableViewController: UITableViewController {
	
	let cars: [CarsModel] = [
		CarsModel(id:  "535e8de8-721b-4bac-8b72-7d29be7da467", brand: "Audi", name:  "RS 5 Coupé", about:  "O carro ainda tem sistema de tração nas quatro rodas Quattro com diferencial traseiro esportivo de série. De acordo com a Audi, ele faz o mesmo em 3,8 segundos na Sportback.", rent: Rent(period:  "Ao dia", price: 120), fuelType: "Gasolina", thumbNail:  "Corvete", accessories: [Acessories(type:  "speed", name:  "250km/h"),Acessories(type: "acceleration", name:  "3.8s")]),
		CarsModel(id: "ffb71f55-818a-48b1-b7d2-2efc406ede25", brand:  "Porsche", name:"Panamera", about:   "O Panamera é um automóvel de luxo coupé com porte grande. Tem motorização dianteira V6 e V8. A tração é integral com uma caixa PDK de sete mudanças e dupla embreagem.", rent: Rent(period:  "Ao dia", price: 120), fuelType: "Gasolina", thumbNail:   "Porche", accessories: [Acessories(type:  "speed", name:  "250km/h"),Acessories(type: "acceleration", name:  "3.8s")]),
	]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil),forCellReuseIdentifier: "cellCars")
	}
	
	// MARK: - Table view data source
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cars.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellCars", for: indexPath) as! CarTableViewCell
		let car = cars[indexPath.row]
		
		cell.populetedCell(car)
		
		return cell
	}
	
	
	
}
