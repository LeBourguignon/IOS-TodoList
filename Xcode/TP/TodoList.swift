//
//  TodoList.swift
//  TP
//
//  Created by Baptiste Andres on 06/12/2022.
//

import Foundation

class TodoList {
    var name:String;
    var list:[Todo];
    
    init(name:String = "", list:[Todo] = []) {
        self.name = name;
        self.list = list;
    }
}
