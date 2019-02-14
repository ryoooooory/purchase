//
//  Item.swift
//  purchase
//
//  Created by 大嶋　涼 on 2019/02/13.
//  Copyright © 2019年 大嶋　涼. All rights reserved.
//
import FirebaseDatabase
import Foundation

class Item{
    var name = ""
    var num = 0
    init(snapshot:DataSnapshot) {
        self.name        = snapshot.childSnapshot(forPath: "name").value as! String
        self.num      = snapshot.childSnapshot(forPath: "num").value as! Int
    }
}
