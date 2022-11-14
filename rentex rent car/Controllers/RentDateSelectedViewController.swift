//
//  RentDateSelectedViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 14/11/22.
//

import UIKit

class RentDateSelectedViewController: UIViewController {

	@IBOutlet weak var dateRentSelcet: UIDatePicker!
	@IBOutlet weak var viewFinalDate: UIView!
	@IBOutlet weak var viewInitalDate: UIView!
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func handleSelectDatePicker(_ sender: UIDatePicker) {
	}
	
 
	@IBAction func handleConfirmRent(_ sender: UIButton) {
	}
	
}
