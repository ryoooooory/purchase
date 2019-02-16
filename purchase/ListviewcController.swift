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


class ChatTargetUserCell:UITableViewCell{
    @IBOutlet weak var nameLabel:UILabel!
    
    func bind(item:Item){
        print(item.name)
        
        self.nameLabel.text = ("\(item.name)  \(item.price)円" )
    }
    
    
    func sumdata(item:Item) -> Int{
        return item.price
    }
}




class ListviewController: UITableViewController{
    
    var items = [Item]()
    var countitems = [Item]()                   //データ数を数える用
    
    var ref: DatabaseReference!
    var counter = 1;                    //セルの番号
    var sum = 0;                        //合計金額
    var barcode = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
        counter = 1
        if(barcode != ""){                      //バーコード読み取って購入履歴に追加する時。
            self.countList()
        }else{                                  //購入履歴から来た時。
            self.makeList()
        }
    }
    
    
    
    //今あるデータ数をカウントしてcountitemに入れていく
    func countList(){
        ref = Database.database().reference()
        print("countstart")
        //情報取得
        ref.child("user").observeSingleEvent(of: DataEventType.value, with: {(snapshot)  in          //userより下のデータをsnapshotで取得
            self.countitems = [Item]()
            for data in snapshot.children{
                if let snap = data as? DataSnapshot{
                    print(data)
                    let dataitem = Item(snapshot: snap)
                    self.countitems.append(dataitem)
                }
            }
            print("countend")
            self.finditem()
        })
    }
    
    
    
    
    
    //商品登録のところからbarcodeの商品を探し出す、そしてcountitemの数を元にidを決定し更新
    func finditem(){
        print("findstart")
        ref = Database.database().reference()
        ref.child("data/\(barcode)").observeSingleEvent(of: DataEventType.value, with: {(snapshot)  in          //userより下のデータをsnapshotで取得
            var id = self.countitems.count
            
            
            let dataitem = Item(snapshot: snapshot)
            
            
            let updataname = ["name":dataitem.name]
            let updataprice = ["price":dataitem.price]
            
            
            self.ref.child("user/\(id+1)").updateChildValues(updataname)        //idを取得して、データベースに追加
            self.ref.child("user/\(id+1)").updateChildValues(updataprice)        //idを取得して、データベースに追加
            
            print("uploadfinish")
            print("findend")
            self.makeList()
            
        })
        
    }
    
    
    //itemsにデータを入れていく
    func makeList(){
        ref = Database.database().reference()
        print("make")
        //情報取得
        ref.child("user").observeSingleEvent(of: DataEventType.value, with: {(snapshot)  in          //userより下のデータをsnapshotで取得
            self.items = [Item]()
            for data in snapshot.children{
                if let snap = data as? DataSnapshot{
                    let dataitem = Item(snapshot: snap)
                    self.items.append(dataitem)
                }
            }
            print("makeend")
            self.tableView.reloadData()                 //cellをつくり始める
            
        })
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("appear")
     //   tableView.reloadData()
        
        
    }
    
    
    //表示するセルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tablecount")
        print(items.count)
        return items.count+1                       //最後のセルは合計金額を出す
        
    }
    
    
    //セルの作成、最後に呼ばれる
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("table")
        print(counter)
        if counter == items.count+1{                //最後のセルだったら合計金額をセルのtextに入れる
            
            // let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            // let cxell = tableView.cellForRow(at: indexPath)
            //  var cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatTargetUserCell
            cell.textLabel?.text = "合計\(sum)円"
            
            return cell
            
        }else{                                      //それ以外はFirebaseから取得したものを入れていく
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatTargetUserCell
            let item = self.items[indexPath.row]
            cell.bind(item: item)                           //Firebaseから取得したデータ(items)からそれぞれの要素に分解
            counter += 1                                    //cellが何番目かカウント
            sum += cell.sumdata(item: item)                 //合計金額にプラスしていく
            
            return cell
        }
    }
    
    
    
}
