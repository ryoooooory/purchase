//
//  ListviewcController.swift
//  purchase
//
//  Created by 大嶋　涼 on 2019/02/13.
//  Copyright © 2019年 大嶋　涼. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class ListviewController: UITableViewController{
    
    var cellnum = 0;
    var items = [Item]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("List")
//        makeList()
    }
    //表示するセルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellnum
    }
    
    //セルの作成
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(items[0].name)  \(items[0].num)"
        return cell
    }
    
    //情報表示
//    func makeList(){
//        self.items = []
//        var counter = 0
//        ref = Database.database().reference()
//        var x = ""
//
//
//        //情報取得
//        ref.child("user").observeSingleEvent(of: .value, with:{(snapshot) in x = ((snapshot.value! as AnyObject).description)!
//
//            var data: Data =  x.data(using: String.Encoding.utf8)!          //json形式
//
//            let jsonData = try JSONSerialization.data(withJSONObject: x)
//            let jsonStr = String(bytes: x, encoding: .utf8)!
//
//            print("json  \(jsonStr)")
//
//
//            counter += 1
//        })
//
//        cellnum = counter
//
//    }
    
}
