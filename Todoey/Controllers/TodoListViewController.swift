//
//  ViewController.swift
//  Todoey
//
//  Created by juyeong koh on 2022/10/14.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension("Items.plist")
    
    // userDefaults (사용자 인터페이스)
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
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
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
            
            loadItems()
            
        }
        
    }
    
    
    // MARK: - Tableview Datasource Methods
    
    // 섹션의 행 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // 행에 대한 셀
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    
    
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        // 이 메서드 내에서 현재 인덱스 경로의 항목을 토글
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "새 Todoey 항목 추가", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "항목 추가", style: .default) { [self] (action) in
            
            // 사용자가 UIAlert에서 항목 추가 버튼을 클릭하면 어떻게 되는지
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
            
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
    
    
    // MARK: - Model Manupulation Methods (모델 조작 방법)
    
    func saveItems() {
        
        // 사용자 정의 개체의 배열을 plist에 쓸 수 있는 데이터로 만든 다음 해당 데이터가 필요할 때
        let encoder = PropertyListEncoder()
        
        do {
            // 데이터를 인코딩
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    // plist decoder를 사용하여 항목 배열의 형태로 해당 데이터를 가져옴 
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}
