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
	
	var eventsPerRound: Int = 4
	
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
		view.layer.cornerRadius = 8
		
		
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
		
		if tag == 0 {
			
			let normalStateImage = UIImage(named: "down_full")
			let hStateImage = UIImage(named: "down_full_selected")
			
			let button = addSingleButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			var ratio: CGFloat = 1.0
			
			if let img = normalStateImage {
				
				ratio = img.size.width / img.size.height
			}
			
			setConstraintsForFull(button, relativeTo: view, ratio: ratio)
			
		} else if tag == eventsPerRound - 1 {
			
			let normalStateImage = UIImage(named: "up_full")
			let hStateImage = UIImage(named: "up_full_selected")
			
			let button = addSingleButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			var ratio: CGFloat = 1.0
			
			if let img = normalStateImage {
				
				ratio = img.size.width / img.size.height
			}
			
			setConstraintsForFull(button, relativeTo: view, ratio: ratio)
			
		} else {
			
			//add 2 buttons
			
			var normalStateImage = UIImage(named: "up_half")
			var hStateImage = UIImage(named: "up_half_selected")
			
			let buttonUp = addSingleButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			var ratio: CGFloat = 1.0
			
			if let img = normalStateImage {
				
				ratio = img.size.width / img.size.height
			}
			
			setConstraintsForUpperHalf(buttonUp, relativeTo: view, ratio: ratio)
			
			
			normalStateImage = UIImage(named: "down_half")
			hStateImage = UIImage(named: "down_half_selected")
			
			let buttonDown = addSingleButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			ratio = 1.0
			
			if let img = normalStateImage {
				
				ratio = img.size.width / img.size.height
			}
			
			setConstraintsForLowerHalf(buttonDown, relativeTo: view, ratio: ratio)
			
		}

		
	}
	
	func addSingleButton(toView parentView: UIView, normalStateImage: UIImage? = nil, highlightedStateImage: UIImage? = nil) -> UIButton {
		
		//let marginGuide = parentView.layoutMarginsGuide
		
		let button = UIButton()
		
		//var ratio: CGFloat = 1.0
		
		if let image = normalStateImage {
			
			//ratio = image.size.width / image.size.height
			
			button.setImage(image, forState: .Normal)
		}
		
		if let image = highlightedStateImage {
			
			button.setImage(image, forState: .Highlighted)
		}
		
		parentView.addSubview(button)
		
		return button
		
//		button.translatesAutoresizingMaskIntoConstraints = false
//		
//		button.trailingAnchor.constraintEqualToAnchor(marginGuide.trailingAnchor,constant: 0).active = true
//		button.centerYAnchor.constraintEqualToAnchor(marginGuide.centerYAnchor).active = true
//		button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor).active = true
//		button.widthAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, multiplier: ratio).active = true
	}
	
	func setConstraintsForFull(button: UIButton, relativeTo parentView: UIView, ratio: CGFloat) {
		
		let marginGuide = parentView.layoutMarginsGuide
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		button.trailingAnchor.constraintEqualToAnchor(marginGuide.trailingAnchor,constant: 0).active = true
		button.centerYAnchor.constraintEqualToAnchor(marginGuide.centerYAnchor).active = true
		button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor).active = true
		button.widthAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, multiplier: ratio).active = true
	}
	
	func  setConstraintsForUpperHalf(button: UIButton, relativeTo parentView: UIView, ratio: CGFloat) {
		
		let marginGuide = parentView.layoutMarginsGuide
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		button.trailingAnchor.constraintEqualToAnchor(marginGuide.trailingAnchor,constant: 0).active = true
		button.topAnchor.constraintEqualToAnchor(marginGuide.topAnchor, constant: 0).active = true
		button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, multiplier: 0.5, constant: 0).active = true
		button.widthAnchor.constraintEqualToAnchor(button.heightAnchor, multiplier: ratio).active = true
	}
	
	func  setConstraintsForLowerHalf(button: UIButton, relativeTo parentView: UIView, ratio: CGFloat) {
		
		let marginGuide = parentView.layoutMarginsGuide
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		button.trailingAnchor.constraintEqualToAnchor(marginGuide.trailingAnchor,constant: 0).active = true
		button.bottomAnchor.constraintEqualToAnchor(marginGuide.bottomAnchor, constant: 0).active = true
		button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, multiplier: 0.5, constant: 0).active = true
		button.widthAnchor.constraintEqualToAnchor(button.heightAnchor, multiplier: ratio).active = true
	}


	
	@IBAction func addAction(sender: AnyObject) {
		
		for i in 0..<eventsPerRound {

			//addButtonTo(stack: eventStack, text: "Option \(i+1)", tag: i, color: UIColor.blueColor())
			
			addViewTo(stack: eventStack, text: "Option \(i+1)", tag: i, color: UIColor.whiteColor())
		}
	}
	@IBAction func removeAction(sender: AnyObject) {
		
		//removeViews(ofType: UIButton.self, from: eventStack)
		removeViews(ofType: UIView.self, from: eventStack)
	}
	
	
}

