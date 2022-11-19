//
//  ScheduleCompleteViewController.swift
//  rentex rent car
//
//  Created by kenjimaeda on 19/11/22.
//

import UIKit

class ScheduleCompleteViewController: UIViewController {

	@IBOutlet weak var viewCheck: UIView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		   
	
		viewCheck.layer.borderWidth = 5
		viewCheck.layer.borderColor = UIColor(named:"gray300")!.cgColor
		viewCheck.layer.cornerRadius = 5
		viewCheck.backgroundColor = .clear
	  navigationController?.setNavigationBarHidden(true, animated: true)
		navigationController?.navigationBar.barStyle = .black
		
    }
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
    
	@IBAction func handleConfirm(_ sender: Any) {
	}


}
