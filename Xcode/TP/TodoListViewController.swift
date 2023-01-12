//
//  TodoListViewController.swift
//  TP
//
//  Created by Baptiste Andres on 07/11/2022.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.list.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTodoList", for: indexPath) as! TodoListTableViewCell;
        cell.myLabel.text = todoList.list[indexPath.row].name;
        cell.mySwitch.setOn(todoList.list[indexPath.row].isDone, animated: true);
        cell.mySwitch.tag = indexPath.row
        return cell;
    }
    

    var todoList = TodoList();
    
    @IBOutlet weak var myTitle: UINavigationItem!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var parentTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTitle.title = todoList.name;
        todoList.list.sort() { $0.date.description < $1.date.description }
        myTableView.dataSource = self;
    }
    
    @IBAction func clicSwitch(_ sender: UISwitch) {
        let row = sender.tag;
        todoList.list[row].isDone = sender.isOn;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DescViewController {
            let row = myTableView.indexPathForSelectedRow!.row;
            vc.data = todoList.list[row];
        }
    }
    
    @IBAction func del(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is DescViewController {
            let row = myTableView.indexPathForSelectedRow!.row;
            todoList.list.remove(at: row);
            todoList.list.sort() { $0.date.description < $1.date.description }
            myTableView.reloadData();
            if parentTableView != nil {
                parentTableView?.reloadData();
            }
        }
    }
    
    @IBAction func add(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? AddViewController {
            if let name = vc.name.text, let desc = vc.desc.text {
                if !name.isEmpty {
                    let newTodo = Todo(name: name, desc: desc, date: vc.date.date);
                    todoList.list.append(newTodo);
                    todoList.list.sort() { $0.date.description < $1.date.description }
                    myTableView.reloadData();
                    if parentTableView != nil {
                        parentTableView?.reloadData();
                    }
                }
            }
        }
    }
}
