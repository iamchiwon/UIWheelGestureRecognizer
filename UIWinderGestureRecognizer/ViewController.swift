//
//  ViewController.swift
//  UIWinderGestureRecognizer
//
//  Created by iamchiwon on 2016. 3. 15..
//  Copyright © 2016년 iamchiwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tracker: UIView!
    @IBOutlet weak var mask: UIView!
    @IBOutlet weak var angle: UILabel!
    @IBOutlet weak var direction: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init UI
        tracker.layer.cornerRadius = 100
        mask.layer.cornerRadius = 50
        self.direction.text = ""
        self.angle.text = ""
        
        setGestureRecognizer()
    }

    func setGestureRecognizer() {
        let winder = UIWinderGestureRecognizer()
        winder.minDistance = 50
        winder.maxDistance = 100
        winder.setHandler { (recognizer) -> (Void) in
            if recognizer.state == .Changed {
                self.direction.text = recognizer.direction.rawValue
                self.angle.text = NSString(format: "%.2f", recognizer.angle) as String
            } else {
                self.direction.text = ""
                self.angle.text = ""
            }
            
        }
        tracker.addGestureRecognizer(winder)
    }

}

