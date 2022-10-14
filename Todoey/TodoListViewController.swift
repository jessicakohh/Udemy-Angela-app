//
//  ViewController.swift
//  Todoey
//
//  Created by juyeong koh on 2022/10/14.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["할일1", "할일2", "할일3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Tableview Datasource Methods
    
    // 섹션의 행 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // 행에 대한 셀
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView DelegateMethods
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "새 Todoey 항목 추가", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "항목 추가", style: .default) { (action) in
            
            // 사용자가 UIAlert에서 항목 추가 버튼을 클릭하면 어떻게 되는지
            self.itemArray.append(textField.text!)
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


