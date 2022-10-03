//
//  File.swift
//  Todoey
//
//  Created by juyeong koh on 2022/10/03.
//  Copyright © 2022 App Brewery. All rights reserved.
//


import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArrray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArrray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
         
        cell.textLabel?.text = itemArrray[indexPath.row]
        
        return cell
    }

}


