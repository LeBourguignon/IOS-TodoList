//
//  SearchViewController.swift
//  TP
//
//  Created by Baptiste Andres on 09/01/2023.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTodoList", for: indexPath) as! TodoListTableViewCell;
        cell.myLabel.text = displayData[indexPath.row].name;
        cell.mySwitch.setOn(displayData[indexPath.row].isDone, animated: true);
        cell.mySwitch.tag = indexPath.row
        return cell;
    }
    
    var myData:[Todo] = [];
    
    var displayData:[Todo] = [];
    
    @IBOutlet weak var myTableView: UITableView!
    
    var parentTableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayData = myData;
        
        displayData.sort() { $0.date.description < $1.date.description }
        
        myTableView.dataSource = self;
    }
    
    @IBAction func clicSwitch(_ sender: UISwitch) {
        let row = sender.tag;
        displayData[row].isDone = sender.isOn;
        myTableView.reloadData();
    }
    
    @IBAction func search(_ sender: UITextField) {
        let french = DateFormatter();
        french.dateStyle = .medium;
        french.timeStyle = .medium;
        french.locale = Locale(identifier: "FR-fr");
        
        displayData = myData.filter { $0.name.contains(sender.text!) || $0.desc.contains(sender.text!) || french.string(from: $0.date).contains(sender.text!) || sender.text == "" }
        
        myTableView.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DescViewController {
            let row = myTableView.indexPathForSelectedRow!.row;
            vc.data = displayData[row];
        }
    }
    
    @IBAction func del(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is DescViewController {
            let row = myTableView.indexPathForSelectedRow!.row;
            myData.removeAll() { $0 === displayData[row] }
            if parentTableView != nil {
                parentTableView?.reloadData();
            }
        }
    }
}
