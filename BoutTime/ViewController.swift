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
	let maxRounds: Int = 6
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
			
			checkRoundResluts(eventSet)
		}
	}
	
	
	func removeViews(ofType viewtype: UIView.Type, from superView: UIView){
		
		for subView in superView.subviews {
			
			if subView.isKindOfClass(viewtype) {
				
				subView.removeFromSuperview()
			}
		}
	}
	
	func addViewTo(stack stackView: UIStackView, text: String, color: UIColor, tag: Int) {
		
		let view = UIView()
		
		view.clipsToBounds = true
		
		view.backgroundColor = color
		view.tag = tag + 100 //views tags are 100, 101, 102 etc., to distinguish them later
		view.layer.cornerRadius = 8
		
		view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)//insets
		
		stackView.addArrangedSubview(view)
		
		//for clarity
		let zeroTag = 0
		let lastTag = eventsPerRound - 1
		
		//referernce to the button (at least one) needed to apply trailing constraint to the label later
		var button: UIButton?
		
		//first tile
		if tag == zeroTag || tag == lastTag {
			
			let normalStateImage = (tag == zeroTag) ? UIImage(named: arrowFileNames.downFull.rawValue) : UIImage(named: arrowFileNames.upFull.rawValue)
			let hStateImage = (tag == zeroTag) ? UIImage(named: arrowFileNames.downFullSelected.rawValue) : UIImage(named: arrowFileNames.upFullSelected.rawValue)
			
			let buttTuple = buttonTuple(normalStateImage, highlightedStateImage: hStateImage)
			
			button = buttTuple.button
			
			//Justified force-unwrapping
			view.addSubview(button!)
			
			setConstraintsForFull(button!, relativeTo: view, ratio: buttTuple.ratio)
			
		
		//all inner tiles
		} else if tag < lastTag {
			
			//add 2 buttons:
			//I
			var normalStateImage = UIImage(named: arrowFileNames.upHalf.rawValue)
			var hStateImage = UIImage(named: arrowFileNames.upHalfSelected.rawValue)
			
			let buttonUpTuple = buttonTuple(normalStateImage, highlightedStateImage: hStateImage)
			
			button = buttonUpTuple.button
			
			//Justified force-unwrapping
			view.addSubview(button!)
			
			setConstraintsForUpperHalf(button!, relativeTo: view, ratio: buttonUpTuple.ratio)
			
			//II
			normalStateImage = UIImage(named: arrowFileNames.downHalf.rawValue)
			hStateImage = UIImage(named: arrowFileNames.downHalfSelected.rawValue)
			
			let buttonDownTuple = buttonTuple(normalStateImage, highlightedStateImage: hStateImage)
			
			view.addSubview(buttonDownTuple.button)
			
			setConstraintsForLowerHalf(buttonDownTuple.button, relativeTo: view, ratio: buttonDownTuple.ratio)
		}
		
		//=====Label
		let label = UILabel()
		label.text = text
		label.textColor = UIColor(red: 17.0 / 255, green: 76.0 / 255, blue: 105.0 / 255, alpha: 1.0)
		label.tag = tag + 1000 //label tags are 1000, 1001, 1002 etc., to distinguish them later
		
		view.addSubview(label)
		
		setConstraintsForLabel(label, relativeTo: view, secondaryAnchorProvider: button)
		
		//add interaction to the label
		label.userInteractionEnabled = true
		label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openWebPage)))
	}
	
	
	func openWebPage(sender: UITapGestureRecognizer) {
		
		let label: UILabel = sender.view as! UILabel
		
		let tag = label.tag - 1000 //unparsing tag from label tag. Now it is 0,1,2,3 etc.
		
		if let urlString = eventSet?[tag].urlString, let url = NSURL(string: urlString) {
			
			let webVC = SFSafariViewController(URL: url)
			webVC.delegate = self
			self.presentViewController(webVC, animated: true, completion: nil)

		} else {
			
			let controller = UIAlertController(title: nil, message: "No web-page available", preferredStyle: .Alert)
			controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
			presentViewController(controller, animated: true, completion: nil)
		}
	}
	
	func buttonTuple(normalStateImage: UIImage? = nil, highlightedStateImage: UIImage? = nil) -> (button: UIButton, ratio: CGFloat) {
		
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
			
			checkRoundResluts(eventSet)
		}
	}
	
	
	func checkRoundResluts(historyEventSet: [HistoryEvent]?) {
		
		roundInProgress = false
		
		timerlabel.hidden = true
		
		if let historyEventSet = historyEventSet {
		
			let sortedSet = historyEventSet.sort()
			
			var image: UIImage?
			
			if sortedSet == historyEventSet {
				
				image = UIImage(named: "next_round_success")
				
				score += 1
				
			} else {
				
				image = UIImage(named: "next_round_fail")
			}
			
			let buttTuple = buttonTuple(image, highlightedStateImage: image)
			
			contrainerView.addSubview(buttTuple.button)
			
			setContstraintsForNextRoundButton(buttTuple.button, relativeTo: contrainerView, ratio: buttTuple.ratio)
			
			infoLabel.text = "Tap events to learm more"
			
			//Ugly, but still have no idea how to pass action as parameter
			buttTuple.button.removeTarget(self, action: #selector(swapElements), forControlEvents: .TouchUpInside)
			buttTuple.button.addTarget(self, action: #selector(newRound), forControlEvents: .TouchUpInside)
		
		} else {
			
			//just try again. Although this should never happen
			newRound()
		}
	}
	
	func safariViewControllerDidFinish(controller: SFSafariViewController) {
		controller.dismissViewControllerAnimated(true, completion: nil)
	}
	
	//MARK: Constraints
	func setConstraintsForFull(button: UIButton, relativeTo parentView: UIView, ratio: CGFloat) {
		
		let marginGuide = parentView.layoutMarginsGuide
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		button.trailingAnchor.constraintEqualToAnchor(marginGuide.trailingAnchor,constant: 0).active = true
		
		button.centerYAnchor.constraintEqualToAnchor(marginGuide.centerYAnchor).active = true
		button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor).active = true
		button.widthAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, multiplier: ratio).active = true
	}
	
	func setContstraintsForNextRoundButton(button: UIButton, relativeTo parentView: UIView, ratio: CGFloat) {
		
		let marginGuide = contrainerView.layoutMarginsGuide
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		button.centerXAnchor.constraintEqualToAnchor(marginGuide.centerXAnchor).active = true
		button.topAnchor.constraintEqualToAnchor(marginGuide.topAnchor, constant: 8).active = true
		button.heightAnchor.constraintEqualToAnchor(marginGuide.heightAnchor, constant: 0).active = true
		button.widthAnchor.constraintEqualToAnchor(button.heightAnchor, multiplier: ratio).active = true
	}
	
	func setConstraintsForLabel(label: UILabel, relativeTo parentView: UIView, secondaryAnchorProvider: UIView?) {
		
		let marginGuide = parentView.layoutMarginsGuide
		
		label.translatesAutoresizingMaskIntoConstraints = false
		
		var trailingAnchor: NSLayoutXAxisAnchor
		
		if let button = secondaryAnchorProvider {
			
			trailingAnchor = button.leadingAnchor
			
		} else {
			
			trailingAnchor = view.trailingAnchor
		}
		
		label.leadingAnchor.constraintEqualToAnchor(marginGuide.leadingAnchor, constant: 20).active = true
		label.centerYAnchor.constraintEqualToAnchor(marginGuide.centerYAnchor).active = true
		label.topAnchor.constraintEqualToAnchor(marginGuide.topAnchor, constant: 20).active = true
		label.bottomAnchor.constraintEqualToAnchor(marginGuide.bottomAnchor, constant: -20).active = true
		label.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -20).active = true
		
		label.numberOfLines = 0
		label.lineBreakMode = .ByWordWrapping
		
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
	
}

