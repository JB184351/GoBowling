//
//  CreateToDoViewController.swift
//  ToDo
//
//  Created by Justin Bengtson on 3/5/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class CreateToDoViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var creatingTaskName: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    var ToDoTableVC : ToDoTableViewController? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatingTaskName.delegate = self
        
    }
    
    // Touches Began and textFieldShouldClear function help hide the keyboard
    // when the user touches outside of the keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    @IBAction func addTask(_ sender: Any) {
        // Manged Object Context and doing if let allows us to unwrap an optional
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newToDo = ToDoSave(context: context)
            newToDo.important = importantSwitch.isOn
            if let name = creatingTaskName.text {
                newToDo.name = name
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
       
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
