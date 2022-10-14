//
//  ViewController.swift
//  Todoey
//
//  Created by juyeong koh on 2022/10/14.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    // userDefaults (사용자 인터페이스)
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "할일1"
        newItem.done = true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "할일2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "할일3"
        itemArray.append(newItem3)
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
        
    }
    
    
    // MARK: - Tableview Datasource Methods
    
    // 섹션의 행 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // 행에 대한 셀
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "새 Todoey 항목 추가", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "항목 추가", style: .default) { (action) in
            
            // 사용자가 UIAlert에서 항목 추가 버튼을 클릭하면 어떻게 되는지
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        // 텍스트필드가 있는 UIAlert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "새 항목 만들기"
            textField = alertTextField
            print(alertTextField.text)
            print("+를 눌렀을 때")
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


