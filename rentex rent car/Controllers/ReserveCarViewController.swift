//
//  ReserveCarViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 16/11/22.
//

import UIKit

class ReserveCarViewController: UIViewController {
	
	//MARK: - IBOUtlet
	@IBOutlet weak var labPriceTotal: UILabel!
	@IBOutlet weak var labPriceDetailsTotal: UILabel!
	@IBOutlet weak var labDateFinal: UILabel!
	@IBOutlet weak var labDateInitial: UILabel!
	@IBOutlet weak var labName: UILabel!
	@IBOutlet weak var labPrice: UILabel!
	@IBOutlet weak var labBrand: UILabel!
	
	//MARK: - Vars
	//seria ideal verificar se esta no intervalo de datas
	//momento estou adicionado apenas as selecionadas e nao um intervalo
	var totalDateRent: [String]?
	var initialAndFinalDate: [String:String]?
	var car: CarsModel?
	//MAR: - VARS
	var accesories: [Acessories] =  []
	var requestManger = RequestManager()
	var priceTotalCurrency: String?
	let defaultsUserId = UserDefaults.standard
  
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let car = car,let detailsRent = totalDateRent,let initialAndFinalDate = initialAndFinalDate {
			accesories = car.accessories
			let priceTotal = car.rent.price * Double(detailsRent.count)
			priceTotalCurrency = NumberFormatter.localizedString(from: priceTotal as NSNumber, number: .currency)
			labPriceTotal.text = "\(priceTotalCurrency!)"
			labPriceDetailsTotal.text = "\(car.rent.price) x \(detailsRent.count)"
			labName.text = car.name
			labBrand.text = car.brand
			labDateInitial.text = initialAndFinalDate["initialDate"]
			labDateFinal.text = initialAndFinalDate["finalDate"]
			labPrice.text = "R$\(car.rent.price)"
			
		}
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		if let navigation = navigationController?.navigationBar {
			makeNavigationController(color: "white", navigation: navigation)
		}
		navigationController?.navigationBar.tintColor = .black
		self.navigationController?.navigationBar.topItem?.title = "";
	
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}
	
	@IBAction func handleConfirm(_ sender: UIButton)  {
		let userId = defaultsUserId.object(forKey: "userId") ?? UUID().uuidString
		defaultsUserId.set(userId, forKey: "userId")
		var mounted = false
		
		if let carId = car?.id,let total = priceTotalCurrency,let startDate = initialAndFinalDate?["initialDate"],let endDate = initialAndFinalDate?["finalDate"]{
		
		
			let parametres: [String:Any] = [
				"startDate": startDate,
				"endDate": endDate,
				"userId": userId,
				"carId": carId,
				"totalValue": total
				 
			]
		
			if !mounted {
				
				requestManger.delegatePost = self
				requestManger.postData(parameters: parametres, url: "http://localhost:3000/users")
				 mounted = true
				
			}
			
		}
		
		
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

//MARK- Testar o modal de alarme
//MARK: -PostDelegate
extension ReserveCarViewController: PostDelegate {
	func didFailWithErrorPost(_ error: String) {
		let alert = UIAlertController(title: "Alerta", message: error, preferredStyle: .alert)
		
		let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
		alert.addAction(cancel)
		
		present(alert, animated: true)
		
	}
	
	func shouldReturnWithSucess(_ sucess: Bool) {
		if sucess {
			performSegue(withIdentifier: "scheduleCompleteSegue", sender: nil)
		}
	}
	
	
	
}
