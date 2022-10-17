//
//  ViewController.swift
//  Todoey
//
//  Created by juyeong koh on 2022/10/14.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
            
        }
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // userDefaults (사용자 인터페이스)
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
                
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
        
        
        // ✨D
//        // 영구 데이터 소스에서 데이터 제거
//        context.delete(itemArray[indexPath.row])
//        // 테이블 뷰 데이터 소스 로드
//        itemArray.remove(at: indexPath.row)
        
        
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
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
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
    
    // context를 커밋해와야함
    func saveItems() {
        
        do {
            // 데이터를 인코딩
            try context.save()
        } catch {
            print("오류 저장 context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
        // plist decoder를 사용하여 항목 배열의 형태로 해당 데이터를 가져옴 (R)
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }


            do {
                itemArray = try context.fetch(request)
            } catch {
                print("Error fetching data from context \(error)")
            }
        
        tableView.reloadData()
        }
    
}


// MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS [cd] %@", searchBar.text!)
                
        // 데이터베이스에서 가져온 데이터를 실제로 정렬
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
