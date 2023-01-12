//
//  Todo.swift
//  TP
//
//  Created by Baptiste Andres on 07/11/2022.
//

import Foundation

class Todo {
    var name:String;
    var desc:String;
    var isDone:Bool = false;
    var date:Date;
    
    init(name:String, desc:String, date:Date = Date.init()) {
        self.name = name;
        self.date = date;
        self.desc = desc;
    }
}
