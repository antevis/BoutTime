//
//  ViewController.swift
//  BoutTime
//
//  Created by Ivan Kazakov on 01/07/16.
//  Copyright © 2016 Antevis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var superView: UIView!
	@IBOutlet weak var view0: UIView!
	@IBOutlet weak var view1: UIView!
	@IBOutlet weak var view2: UIView!
	@IBOutlet weak var view3: UIView!

	@IBOutlet weak var downBigButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
//		view0.clipsToBounds = true
//		view0.layer.cornerRadius = 64
//		
//		view1.clipsToBounds = true
//		view1.layer.cornerRadius = 64
//		
//		view2.clipsToBounds = true
//		view2.layer.cornerRadius = 64
//		
//		view3.clipsToBounds = true
//		view3.layer.cornerRadius = 64
		
		let views = [view0, view1, view2, view2, view3]
		
		for subView in views {
			
			subView.clipsToBounds = true
			subView.layer.cornerRadius = 10
		}
		
		downBigButton.setImage(UIImage(named: "down_full_selected"), forState: .Highlighted)
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func downButton(sender: AnyObject) {
		
		
	}

}

