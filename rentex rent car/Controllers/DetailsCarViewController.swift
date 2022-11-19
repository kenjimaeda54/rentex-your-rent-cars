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
	var accesories: [Acessories] =  []
	var car: CarsModel?
  let sectionInsets = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
	
	override func viewDidLoad() {
		super.viewDidLoad()
			
		
		guard let car = car else {return}
		
		accesories = car.accessories
		
		let url = URL(string: car.thumbNail)!
		
		DispatchQueue.global().async {
			if let data = try? Data(contentsOf: url) {
				
				DispatchQueue.main.async {
					self.imgCar.image = UIImage(data: data)
					self.labDay.text = car.rent.period
					self.labBrand.text = car.brand
					self.labDescription.text  = car.about
					self.labPrice.text = "R$\(car.rent.price)"
					self.labName.text = car.name
					
					
				}
				
			}
			
		}
		
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
extension DetailsCarViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return accesories.count
	}
	

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! DetailsCarCollectionViewCell
		let accesories = accesories[indexPath.row]
		cell.populetedCell(accesories)
		return cell

	}
   
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let yourWidth = collectionView.bounds.width/3.5
			let yourHeight = yourWidth

			return CGSize(width: yourWidth, height: yourHeight)
	}
	


 
 
	
}



