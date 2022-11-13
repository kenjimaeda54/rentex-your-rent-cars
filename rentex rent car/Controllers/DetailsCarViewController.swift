//
//  DetailsCarViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 13/11/22.
//

import UIKit

class DetailsCarViewController: UIViewController {
	
	//MARK: - Outllet
	
	@IBOutlet weak var labDescription: UILabel!
	@IBOutlet weak var labPrice: UILabel!
	@IBOutlet weak var labDay: UILabel!
	@IBOutlet weak var labName: UILabel!
	@IBOutlet weak var labBrand: UILabel!
	@IBOutlet weak var imgCar: UIImageView!
	
	//MAR: - VARS
	let accesories: [Acessories] =  [
	    Acessories(type: "Gasolina", name: "380km/h"),
			Acessories(type: "Gasolina", name: "3.2s"),
			Acessories(type: "Gasolina", name: "Gasolina"),
			Acessories(type: "Gasolina", name: "Auto"),
		  Acessories(type: "Gasolina", name: "2 pessoas"),
			Acessories(type: "Gasolina", name: "800 HP"),
	    
	]
	
	var car: CarsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
			
			guard let car = car else {return}
			
			imgCar.image = UIImage(named: car.thumbNail)
			labDay.text = car.rent.period
			labBrand.text = car.brand
			labDescription.text  = car.about
			labPrice.text = "R$\(car.rent.price)"
			labName.text = car.name
			
		}
    
}

extension DetailsCarViewController: UICollectionViewDelegate,UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
		return accesories.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! DetailsCarCollectionViewCell
		
		let accesories = accesories[indexPath.row]
		cell.populetedCell(accesories)
		return cell
		
	}
	
	
}


	
