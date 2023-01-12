//
//  ViewController.swift
//  TP
//
//  Created by Baptiste Andres on 06/12/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell;
        cell.myLabel.text = myData[indexPath.row].name;
        cell.myNumber.text = myData[indexPath.row].list.count.description;
        return cell;
    }
    
    var myData:[TodoList] = [];
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for j in 1...2 {
            var list:[Todo] = []
            for i in 1...10 {
                let name = "Todo " + String(j) + "." + String(i);
                let desc = "Ceci est la todo " + String(j) + "." +  String(i);
                let todo = Todo(name: name, desc: desc);
                list.append(todo);
            }
            let todoList = TodoList(name:"my TodoList " + String(j), list: list);
            myData.append(todoList);
        }
        
        myTableView.dataSource = self;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TodoListViewController {
            let row = myTableView.indexPathForSelectedRow!.row;
            vc.todoList = myData[row];
            vc.parentTableView = myTableView;
        }
        
        if let vc = segue.destination as? SearchViewController {
            var data:[Todo] = [];
            for todoList in myData {
                for todo in todoList.list {
                    data.append(todo);
                }
            }
            vc.myData = data;
            vc.parentTableView = myTableView;
        }
    }
    
    @IBAction func del(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is TodoListViewController {
            let row = myTableView.indexPathForSelectedRow!.row;
            myData.remove(at: row);
            myTableView.reloadData();
        }
    }
    
    @IBAction func add(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? AddTodoListViewController {
            if let name = vc.name.text {
                if !name.isEmpty {
                    let newTodoList = TodoList(name: name);
                    myData.append(newTodoList);
                    myTableView.reloadData();	
                }
            }
        }
    }
}
