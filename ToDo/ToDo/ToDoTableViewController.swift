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
    var ToDoSaves: [ToDoSave] = []
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosSaves = try? context.fetch(ToDoSave.fetchRequest()) {
                if let toDos = toDosSaves as? [ToDoSave] {
                    ToDoSaves = toDos
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoSaves.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let currentToDo = ToDoSaves[indexPath.row]
        
        if currentToDo.important {
            if let name = currentToDo.name {
              cell.textLabel?.text = "❗️" + name
            }
        }
        else {
            cell.textLabel?.text = ToDoSaves[indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = ToDoSaves[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: selectedToDo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createVC = segue.destination as? CreateToDoViewController {
            createVC.ToDoTableVC = self
        }
        
        if let completeVC = segue.destination as? CompleteOrDeleteViewController {
            if let selectedToDo = sender as? ToDo {
                completeVC.task = selectedToDo
        }
    }

    }
}
