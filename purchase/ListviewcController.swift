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


class ChatTargetUserCell: UITableViewCell {
    @IBOutlet weak var nameLabel:UILabel!
    
    func bind(item:Item){
        self.nameLabel.text = ("\(item.name)  \(item.num)個")
    }
}




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
        return items.count
    }
    
    //セルの作成
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatTargetUserCell
        let item = self.items[indexPath.row]
        cell.bind(item: item)
        return cell
    }
    
    //情報表示
    func makeList(){
        self.items = []
        ref = Database.database().reference()
        
        
        //情報取得
        ref.child("user").observe(DataEventType.value) { (snapshot) in
            self.items = [Item]()
            for data in snapshot.children{
                if let snap = data as? DataSnapshot{
                    let dataitem = Item(snapshot: snap)
                    self.items.append(dataitem)
                }
            }
            
            self.tableView.reloadData()
        }
        
    }
    
}
