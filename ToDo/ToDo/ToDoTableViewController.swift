//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Justin Bengtson on 2/26/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    // Array of ToDo items
    var toDos: [ToDo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2 - 175, y: self.view.frame.size.height - 70), size: CGSize(width: 50, height: 50)))
        
        button.backgroundColor = UIColor.white
        
        self.navigationController?.view.addSubview(button)
        
        let toDo1 = ToDo()
        toDo1.name = "Walk the Dog"
        toDo1.important = false
        
        let toDo2 = ToDo()
        toDo2.name = "Do homework"
        toDo2.important = true
        
        toDos = [toDo1, toDo2]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let currentToDo = toDos[indexPath.row]
        
        if currentToDo.important {
            cell.textLabel?.text = toDos[indexPath.row].name + "❗️"
        }
        else {
            cell.textLabel?.text = toDos[indexPath.row].name
        }
        
        

        return cell
    }

}
