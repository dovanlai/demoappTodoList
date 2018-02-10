//
//  ViewController.swift
//  demoappTodoList
//
//  Created by lai on 10/02/2018.
//  Copyright © 2018 lai. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var arr=["mot","town","three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    //select
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func btnAdd(_ sender: Any) {
        var mytext = UITextField()
        let alert = UIAlertController(title: "add new item for todolist", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in
           // print(mytext.text)
            self.arr.append(mytext.text!)
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alerTextfield) in
            alerTextfield.placeholder = "create new item"
            mytext = alerTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

