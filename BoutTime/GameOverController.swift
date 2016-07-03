//
//  GameOverController.swift
//  BoutTime
//
//  Created by Ivan Kazakov on 03.072016.
//  Copyright © 2016 Antevis. All rights reserved.
//

import UIKit

class GameOverController: UIViewController {
	
	

	@IBOutlet weak var gameOverLabel: UILabel!
	
	internal func setLabelText(text: String) {
		
		gameOverLabel.text = text
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	@IBAction func playAgainAction(sender: AnyObject) {
		
		
	}

}
