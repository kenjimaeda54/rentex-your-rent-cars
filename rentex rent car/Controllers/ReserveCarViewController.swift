//
//  ReserveCarViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 16/11/22.
//

import UIKit

class ReserveCarViewController: UIViewController {
	
	//MARK: - Vars
	var dateRent: [String:String]?
	//MAR: - VARS
	let accesories: [Acessories] =  [
			Acessories(type: "Gasolina", name: "380km/h"),
			Acessories(type: "Gasolina", name: "3.2s"),
			Acessories(type: "Gasolina", name: "Gasolina"),
			Acessories(type: "Gasolina", name: "Auto"),
			Acessories(type: "Gasolina", name: "2 pessoas"),
			Acessories(type: "Gasolina", name: "800 HP"),
			
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(dateRent)
	}
	
	
	
	
}


//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension ReserveCarViewController: UICollectionViewDelegate,UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return accesories.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reserveCell", for: indexPath) as! ReserveCollectionViewCell
		
		let accesories = accesories[indexPath.row]
		cell.populetedCell(accesories)
		return cell
		
	}
	
	
}
