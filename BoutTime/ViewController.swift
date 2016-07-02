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
	

	@IBOutlet weak var downBigButton: UIButton!
	
	@IBOutlet weak var eventStack: UIStackView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
//		for subView in views {
//			
//			subView.clipsToBounds = true
//			subView.layer.cornerRadius = 10
//		}
		
		view0.layer.cornerRadius = 10
		
		downBigButton.setImage(UIImage(named: "down_full_selected"), forState: .Highlighted)
		
		//removeViews(ofType: UIView.self, from: eventStack)
		
//		for i in 0...2 {
//			
//			
//		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func downButton(sender: AnyObject) {
		
		
	}
	
	func  removeButtonsFrom(superView: UIView) {
		
		for subView in superView.subviews {
			
			if subView is UIButton {
				
				subView.removeFromSuperview()
			}
		}
	}
	
	func removeViews(ofType viewtype: UIView.Type, from superView: UIView){
		
		for subView in superView.subviews {
			
			if subView.isKindOfClass(viewtype) {
				
				subView.removeFromSuperview()
			}
		}
	}
	
	func addButtonTo(stack stackView: UIStackView, text: String, tag: Int, color: UIColor) {
		
		let button = UIButton()
		button.backgroundColor = color
		button.setTitle(text, forState: .Normal)
		button.titleLabel?.textAlignment = .Center
		button.titleLabel?.lineBreakMode = .ByWordWrapping
		
		
		button.tag = tag
		
		stackView.addArrangedSubview(button)
	}
	
	func addViewTo(stack stackView: UIStackView, text: String, tag: Int, color: UIColor) {
		
		let view = UIView()
		
		view.clipsToBounds = true
		
		view.backgroundColor = color
		view.tag = tag
		view.layer.cornerRadius = 10
		
		
		let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		
		view.layoutMargins = insets
		
		stackView.addArrangedSubview(view)
		
		let marginGuide = view.layoutMarginsGuide
		
		//=====Label
		let label = UILabel()
		label.text = text
		label.textColor = UIColor.blackColor()
		label.sizeToFit()
		
		view.addSubview(label)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.leadingAnchor.constraintEqualToAnchor(marginGuide.leadingAnchor, constant: 20).active = true
		label.centerYAnchor.constraintEqualToAnchor(marginGuide.centerYAnchor).active = true
		
		
		//=====Button
		let button = UIButton()
		
		var ratio: CGFloat = 1.0
		
		if let image = UIImage(named: "down_full") {
			
			ratio = image.size.width / image.size.height
			
			button.setImage(image, forState: .Normal)
		}
	
		
		button.setImage(UIImage(named: "down_full_selected"), forState: .Highlighted)
		
		view.addSubview(button)
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		button.trailingAnchor.constraintEqualToAnchor(marginGuide.trailingAnchor,constant: 0).active = true
		button.centerYAnchor.constraintEqualToAnchor(marginGuide.centerYAnchor).active = true
		button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor).active = true
		button.widthAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, multiplier: ratio).active = true

		
	}


	
	@IBAction func addAction(sender: AnyObject) {
		
		for i in 0...3 {

			//addButtonTo(stack: eventStack, text: "Option \(i+1)", tag: i, color: UIColor.blueColor())
			
			addViewTo(stack: eventStack, text: "Option \(i+1)", tag: i, color: UIColor.whiteColor())
		}
	}
	@IBAction func removeAction(sender: AnyObject) {
		
		//removeViews(ofType: UIButton.self, from: eventStack)
		removeViews(ofType: UIView.self, from: eventStack)
	}
	
	
}

