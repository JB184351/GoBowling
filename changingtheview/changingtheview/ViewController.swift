//
//  ViewController.swift
//  changingtheview
//
//  Created by Justin Bengtson on 1/28/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var width: CGFloat = 0.0
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.frame.size.width
        leftConstraint.constant = width
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func show(_ sender: Any) {
        leftConstraint.constant = 0.0
        print("Show")
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func hide(_ sender: Any) {
        leftConstraint.constant = width
        print("Hide ")
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}

