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
	
	@IBOutlet weak var eventStack: UIStackView!
	
	var eventsPerRound: Int = 3
	
	enum arrowFileNames: String {
		
		case downFull = "down_full"
		case downFullSelected = "down_full_selected"
		case upFull = "up_full"
		case upFullSelected = "up_full_selected"
		case downHalf = "down_half"
		case downHalfSelected = "down_half_selected"
		case upHalf = "up_half"
		case upHalfSelected = "up_half_selected"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		addEventTiles()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
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
		label.textColor = UIColor(red: 17.0 / 255, green: 76.0 / 255, blue: 105.0 / 255, alpha: 1.0)
		label.sizeToFit()
		
		view.addSubview(label)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.leadingAnchor.constraintEqualToAnchor(marginGuide.leadingAnchor, constant: 20).active = true
		label.centerYAnchor.constraintEqualToAnchor(marginGuide.centerYAnchor).active = true
		
		
		
		if tag == 0 {
			
			let normalStateImage = UIImage(named: arrowFileNames.downFull.rawValue)
			let hStateImage = UIImage(named: arrowFileNames.downFullSelected.rawValue)
			
			let button = addSingleButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			setConstraintsForFull(button.button, relativeTo: view, ratio: button.ratio)
			
		} else if tag == eventsPerRound - 1 {
			
			let normalStateImage = UIImage(named: arrowFileNames.upFull.rawValue)
			let hStateImage = UIImage(named: arrowFileNames.upFullSelected.rawValue)
			
			let button = addSingleButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			setConstraintsForFull(button.button, relativeTo: view, ratio: button.ratio)
			
		} else {
			
			//add 2 buttons
			
			var normalStateImage = UIImage(named: arrowFileNames.upHalf.rawValue)
			var hStateImage = UIImage(named: arrowFileNames.upHalfSelected.rawValue)
			
			let buttonUp = addSingleButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			setConstraintsForUpperHalf(buttonUp.button, relativeTo: view, ratio: buttonUp.ratio)
			
			
			normalStateImage = UIImage(named: arrowFileNames.downHalf.rawValue)
			hStateImage = UIImage(named: arrowFileNames.downHalfSelected.rawValue)
			
			let buttonDown = addSingleButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			setConstraintsForLowerHalf(buttonDown.button, relativeTo: view, ratio: buttonDown.ratio)
			
		}

		
	}
	
	func addSingleButton(toView parentView: UIView, normalStateImage: UIImage? = nil, highlightedStateImage: UIImage? = nil) -> (button: UIButton, ratio: CGFloat) {
		
		var ratio: CGFloat = 1.0
		
		let button = UIButton()
		
		if let image = normalStateImage {
			
			button.setImage(image, forState: .Normal)
			
			ratio = image.size.width / image.size.height
		}
		
		if let image = highlightedStateImage {
			
			button.setImage(image, forState: .Highlighted)
		}
		
		parentView.addSubview(button)
		
		return (button: button, ratio: ratio)
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
		
		setCommonHalfButtonConstraints(button, relativeTo: parentView, ratio: ratio, marginGuide: marginGuide)
		
		button.topAnchor.constraintEqualToAnchor(marginGuide.topAnchor, constant: 0).active = true
	}
	
	func  setConstraintsForLowerHalf(button: UIButton, relativeTo parentView: UIView, ratio: CGFloat) {
		
		let marginGuide = parentView.layoutMarginsGuide
		
		setCommonHalfButtonConstraints(button, relativeTo: parentView, ratio: ratio, marginGuide: marginGuide)
		
		button.bottomAnchor.constraintEqualToAnchor(marginGuide.bottomAnchor, constant: 0).active = true
	}
	
	func setCommonHalfButtonConstraints(button: UIButton, relativeTo parentView: UIView, ratio: CGFloat, marginGuide: UILayoutGuide) {
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		button.trailingAnchor.constraintEqualToAnchor(marginGuide.trailingAnchor,constant: 0).active = true
		button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, multiplier: 0.5, constant: 0).active = true
		button.widthAnchor.constraintEqualToAnchor(button.heightAnchor, multiplier: ratio).active = true
	}

	
	func addEventTiles() {
		
		for i in 0..<eventsPerRound {
			
			addViewTo(stack: eventStack, text: "Option \(i+1)", tag: i, color: UIColor.whiteColor())
		}
	}
}

