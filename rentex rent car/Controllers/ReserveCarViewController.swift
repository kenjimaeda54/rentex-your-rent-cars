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
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		//temos as datas inicias,finais e o id
		//MARK: - Implementar restante da logica quando api estiver pronta
	  print(detailsRent)
		
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


