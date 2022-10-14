//
//  ViewController.swift
//  Todoey
//
//  Created by juyeong koh on 2022/10/14.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["할일1", "할일2", "할일3"]

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

}
