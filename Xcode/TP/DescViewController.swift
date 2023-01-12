//
//  DescViewController.swift
//  TP
//
//  Created by Baptiste Andres on 29/11/2022.
//

import UIKit

class DescViewController: UIViewController {

    @IBOutlet weak var name: UILabel!;
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!;
    
    var data: Todo?;
    
    override func viewDidLoad() {
        super.viewDidLoad();

        if let todo = data {
            name.text = todo.name;
            let french = DateFormatter();
            french.dateStyle = .medium;
            french.timeStyle = .medium;
            french.locale = Locale(identifier: "FR-fr");
            date.text = french.string(from: todo.date);
            desc.text = todo.desc;
        }
        else {
            name.text = "Error";
            date.text = "";
            desc.text = "";
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
