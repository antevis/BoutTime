//
//  ViewController.swift
//  BoutTime
//
//  Created by Ivan Kazakov on 01/07/16.
//  Copyright © 2016 Antevis. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {

	@IBOutlet var superView: UIView!
	
	@IBOutlet weak var eventStack: UIStackView!
	@IBOutlet weak var timerlabel: UILabel!
	@IBOutlet weak var infoLabel: UILabel!
	@IBOutlet weak var contrainerView: UIView!
	
	
	var eventsPerRound: Int = 4
	
	let history = HistoryModel()
	
	var eventSet: [HistoryEvent]?
	
	var buttonTag: Int = 0
	
	var timer = NSTimer()
	var seconds: Int = 60
	var score: Int = 0
	var round: Int = 0
	let maxRounds: Int = 2
	var roundInProgress: Bool = false
	
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
		
		newRound()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func newRound() {
		
		if round == maxRounds {
			
			//gameover
			
			print("gameover: \(score):\(maxRounds)")
			
			if let resultController = storyboard?.instantiateViewControllerWithIdentifier("gameOverController") as? GameOverController {
				
				presentViewController(resultController, animated: true, completion: nil)
				
				resultController.gameOverLabel.text = "\(score)/\(maxRounds)"
			}
			
		} else {
			
			roundInProgress = true
		
			round += 1
			
			timer.invalidate()
			
			seconds = 60
			timerlabel.text = TimeConverter.timeStringfrom(seconds: seconds)
			timerlabel.hidden = false
			
			removeViews(ofType: UIView.self, from: eventStack)
			removeViews(ofType: UIButton.self, from: contrainerView)
			
			infoLabel.text = "Shake to complete"
			
			eventSet = history.shuffledEventArrayOf(thisNumberOfEvents: eventsPerRound)
			
			addEventTiles(eventSet)
			
			timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
		}
	}
	
	func decreaseTimer() {
		
		seconds -= 1
		timerlabel.text = TimeConverter.timeStringfrom(seconds: seconds)
		
		if seconds == 0 {
			
			if let eventSet = eventSet {
				
				checkRoundResluts(eventSet)
			} else {
				
				//just trying again
				newRound()
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
	
	func addViewTo(stack stackView: UIStackView, text: String, color: UIColor, tag: Int) {
		
		let view = UIView()
		
		view.clipsToBounds = true
		
		view.backgroundColor = color
		view.tag = tag + 100 //view tags are 100, 101, 102 etc.
		view.layer.cornerRadius = 8
		
		
		let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		
		view.layoutMargins = insets
		
		stackView.addArrangedSubview(view)
		
		let marginGuide = view.layoutMarginsGuide
		
		//for clarity
		let zeroTag = 0
		let lastTag = eventsPerRound - 1
		
		//referernce to the button (at least one) needed to apply trailing constraint to the label later
		var button: UIButton?
		
		//first tile
		if tag == zeroTag || tag == lastTag {
			
			let normalStateImage = (tag == zeroTag) ? UIImage(named: arrowFileNames.downFull.rawValue) : UIImage(named: arrowFileNames.upFull.rawValue)
			let hStateImage = (tag == zeroTag) ? UIImage(named: arrowFileNames.downFullSelected.rawValue) : UIImage(named: arrowFileNames.upFullSelected.rawValue)
			
			let buttonTuple = addButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			button = buttonTuple.button
			
			//One of the rare cases when force-unwrapping justified IMHO
			setConstraintsForFull(button!, relativeTo: view, ratio: buttonTuple.ratio)
			
		
		//all inner tiles
		} else if tag < lastTag {
			
			//add 2 buttons:
			//I
			var normalStateImage = UIImage(named: arrowFileNames.upHalf.rawValue)
			var hStateImage = UIImage(named: arrowFileNames.upHalfSelected.rawValue)
			
			let buttonUpTuple = addButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			button = buttonUpTuple.button
			
			setConstraintsForUpperHalf(button!, relativeTo: view, ratio: buttonUpTuple.ratio)
			
			//II
			normalStateImage = UIImage(named: arrowFileNames.downHalf.rawValue)
			hStateImage = UIImage(named: arrowFileNames.downHalfSelected.rawValue)
			
			let buttonDown = addButton(toView: view, normalStateImage: normalStateImage, highlightedStateImage: hStateImage)
			
			setConstraintsForLowerHalf(buttonDown.button, relativeTo: view, ratio: buttonDown.ratio)
		}
		
		//=====Label
		let label = UILabel()
		label.text = text
		label.textColor = UIColor(red: 17.0 / 255, green: 76.0 / 255, blue: 105.0 / 255, alpha: 1.0)
		label.tag = tag + 1000 //label tags are 1000, 1001, 1002 etc.
		
		view.addSubview(label)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.leadingAnchor.constraintEqualToAnchor(marginGuide.leadingAnchor, constant: 20).active = true
		label.centerYAnchor.constraintEqualToAnchor(marginGuide.centerYAnchor).active = true
		label.topAnchor.constraintEqualToAnchor(marginGuide.topAnchor, constant: 20).active = true
		label.bottomAnchor.constraintEqualToAnchor(marginGuide.bottomAnchor, constant: -20).active = true
		
		var trailingAnchor: NSLayoutXAxisAnchor
		
		if let button = button {
			
			trailingAnchor = button.leadingAnchor
			
		} else {
			
			trailingAnchor = view.trailingAnchor
		}
		
		label.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -20).active = true
		
		label.numberOfLines = 0
		label.lineBreakMode = .ByWordWrapping
		
		label.userInteractionEnabled = true
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(openWebPage))
		
		label.addGestureRecognizer(tap)
		
		//label.addTarget(self, action: #selector(newRound), forControlEvents: .TouchUpInside)
	}
	
	func openWebPage(sender: UITapGestureRecognizer) {
		
		let label: UILabel = sender.view as! UILabel
		
		let tag = label.tag - 1000
		
		if let urlString = eventSet?[tag].urlString, let url = NSURL(string: urlString) {
			
			let webVC = SFSafariViewController(URL: url)
			webVC.delegate = self
			self.presentViewController(webVC, animated: true, completion: nil)
		} else {
			
			//show no web page available messageBox
			print("no web-page availavle")
		}
	}
	
	func addButton(toView parentView: UIView, normalStateImage: UIImage? = nil, highlightedStateImage: UIImage? = nil) -> (button: UIButton, ratio: CGFloat) {
		
		var ratio: CGFloat = 1.0
		
		let button = UIButton()
		
		if let image = normalStateImage {
			
			button.setImage(image, forState: .Normal)
			
			ratio = image.size.width / image.size.height
		}
		
		if let image = highlightedStateImage {
			
			button.setImage(image, forState: .Highlighted)
		}
		
		button.tag = buttonTag
		
		button.addTarget(self, action: #selector(swapElements), forControlEvents: .TouchUpInside)
		
		
		
		buttonTag += 1
		
		parentView.addSubview(button)
		
		return (button: button, ratio: ratio)
	}
	
	func swapElements(sender: UIButton!) {
		
		let lhs = sender.tag / 2
		let rhs = lhs + 1
		
		if eventSet != nil {
			
			swap(&eventSet![lhs], &eventSet![rhs])
			
			let swappees: [Int] = [lhs, rhs]
			
			for swappee in swappees {
				
				reAssignLabelText(swappee)
			}
		}
	}
	
	func setTextFor(tag viewTag: Int, labelCandidate view: UIView) {
		
		if view.tag == viewTag + 1000 {
			
			if let label = view as? UILabel {
				
				label.text = eventSet![viewTag].event
			}
		}
	}
	
	func reAssignLabelText (tag: Int) {
		
		if let upperTile = eventStack.viewWithTag(tag + 100), let labelCandidate = upperTile.viewWithTag(tag + 1000) {
			
			setTextFor(tag: tag, labelCandidate: labelCandidate)
		}
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

	
	func addEventTiles(eventSet: [HistoryEvent]?) {
		
		buttonTag = 0
		
		guard let eventSet = eventSet where eventSet.count > 0 else {
			
			addViewTo(stack: eventStack, text: "No events found. Shake to try again", color: UIColor(red: 204.0 / 255, green: 102.0 / 255, blue: 1.0, alpha: 1.0), tag: 404)
			
			return
		}
		
		for i in 0..<eventSet.count {
			
			addViewTo(stack: eventStack, text: eventSet[i].event, color: UIColor.whiteColor(), tag: i)
		}
	}
	
	override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
		
		if motion == .MotionShake && roundInProgress {
			
			//newRound()
			
			if let eventSet = eventSet {
			
				checkRoundResluts(eventSet)
			} else {
				
				//just trying again
				newRound()
			}
		}
	}
	
	func checkRoundResluts(historyEventSet: [HistoryEvent]) {
		
		roundInProgress = false
		
		let sortedSet = historyEventSet.sort()
		
		timerlabel.hidden = true
		
		var image: UIImage?
		
		if sortedSet == historyEventSet {
			
			image = UIImage(named: "next_round_success")
			
			score += 1
			
		} else {
			
			image = UIImage(named: "next_round_fail")
		}
		
		let button = addButton(toView: contrainerView, normalStateImage: image, highlightedStateImage: image)
		
		let ratio = button.ratio
		
		let marginGuide = contrainerView.layoutMarginsGuide
		
		button.button.translatesAutoresizingMaskIntoConstraints = false
		
		button.button.centerXAnchor.constraintEqualToAnchor(marginGuide.centerXAnchor).active = true
		button.button.topAnchor.constraintEqualToAnchor(marginGuide.topAnchor, constant: 8).active = true
		button.button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, constant: 0).active = true
		button.button.widthAnchor.constraintEqualToAnchor(button.button.heightAnchor, multiplier: ratio).active = true
		
		//button.button.hidden = false
		
		view.bringSubviewToFront(button.button)
		
		infoLabel.text = "Tap events to learm more"
		
		button.button.removeTarget(self, action: #selector(swapElements), forControlEvents: .TouchUpInside)
		
		button.button.addTarget(self, action: #selector(newRound), forControlEvents: .TouchUpInside)
	}
	
	func safariViewControllerDidFinish(controller: SFSafariViewController) {
		controller.dismissViewControllerAnimated(true, completion: nil)
	}
	
}

