//
//  ViewController.swift
//  demoappTodoList
//
//  Created by lai on 10/02/2018.
//  Copyright © 2018 lai. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var arr=[item]()
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        let a = item()
        a.title = "data title 1"
        a.done = false
        arr.append(a)
//        if let items = defaults.array(forKey: "dataArr") as? [item]
//                {
//                    arr = items
//                }
        loadtata()
        
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
        cell.textLabel?.text = arr[indexPath.row].title
        //
       
        if(arr[indexPath.row].done==true){
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    //select
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        arr[indexPath.row].done = !arr[indexPath.row].done
      
        saveItem()
       tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func btnAdd(_ sender: Any) {
        var mytext = UITextField()
        let alert = UIAlertController(title: "add new item for todolist", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in
         
            let a = item()
            a.title = mytext.text!
            a.done = false
            self.arr.append(a)
            //self.defaults.set(self.arr, forKey: "dataArr")
            self.saveItem()
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alerTextfield) in
            alerTextfield.placeholder = "create new item"
            mytext = alerTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItem() {
        let endorder = PropertyListEncoder()
        do{
            let data = try endorder.encode(arr)
            try data.write(to: url!)
        }catch{
            print("loi\(error)")
        }
    }
    func loadtata() {
        if  let data = try? Data(contentsOf: url!){
            let decode = PropertyListDecoder()
            do{
                arr = try decode.decode([item].self, from: data)
            }catch{
                print(error)
            }
        }
    }
}

