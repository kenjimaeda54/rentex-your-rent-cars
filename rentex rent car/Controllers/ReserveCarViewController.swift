//
//  ReserveCarViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 16/11/22.
//

import UIKit

class ReserveCarViewController: UIViewController {
	
	@IBOutlet weak var labPriceTotal: UILabel!
	@IBOutlet weak var labPriceDetailsTotal: UILabel!
	@IBOutlet weak var labDateFinal: UILabel!
	@IBOutlet weak var labDateInitial: UILabel!
	@IBOutlet weak var labName: UILabel!
	@IBOutlet weak var labPrice: UILabel!
	@IBOutlet weak var labBrand: UILabel!
	//MARK: - Vars
	var detailsRent: [String:String]?
	var car: CarsModel?
	//MAR: - VARS
	let accesories: [Acessories] =  []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		//temos as datas inicias,finais e o id
		//MARK: - Implementar restante da logica quando api estiver pronta
	  print(detailsRent,car)
		
		if let navigation = navigationController?.navigationBar {
			makeNavigationController(color: "white", navigation: navigation)
		}
		
	
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}
	
	@IBAction func handleConfirm(_ sender: UIButton) {
	}
}


//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension ReserveCarViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return accesories.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reserveCell", for: indexPath) as! ReserveCollectionViewCell
		
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


