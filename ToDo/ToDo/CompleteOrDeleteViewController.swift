//
//  CompleteOrDeleteViewController.swift
//  ToDo
//
//  Created by Justin Bengtson on 3/5/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class CompleteOrDeleteViewController: UIViewController {
    
    var task = ToDo()
    @IBOutlet weak var taskName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskName.text = task.name
    }
    
    @IBAction func completeTask(_ sender: Any) {
    }
    
    
}
