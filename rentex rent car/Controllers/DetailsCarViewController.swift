//
//  DetailsCarViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 13/11/22.
//

import UIKit

protocol CarsSelectedProtocol {
	func carSelected(_ car: CarsModel)
}

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
	var protocolCar: CarsSelectedProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
			
		
			guard let car = car else {return}
			
			protocolCar?.carSelected(car)
			
			imgCar.image = UIImage(named: car.thumbNail)
			labDay.text = car.rent.period
			labBrand.text = car.brand
			labDescription.text  = car.about
			labPrice.text = "R$\(car.rent.price)"
			labName.text = car.name
			
		}
	
	override func viewWillAppear(_ animated: Bool) {
		 super.viewWillAppear(animated)
 
		//remover o titulo de back
		//https://stackoverflow.com/questions/23853617/uinavigationbar-hide-back-button-text
		self.navigationController?.navigationBar.topItem?.title = "";

		
		if let navigation = navigationController?.navigationBar {
			makeNavigationController(color: "white", navigation: navigation)
		}
		
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}
	
	@IBAction func handleConfirmRent(_ sender: UIButton) {
		performSegue(withIdentifier: "dateSelectCell", sender: nil)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "dateSelectCell" {
			let vc = segue.destination as! RentDateSelectedViewController
			vc.carId = car?.id
		}
	}

	
}


//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
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


	
