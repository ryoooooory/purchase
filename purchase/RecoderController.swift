//
//  RecoderController.swift
//  Purchase
//
//  Created by 大嶋　涼 on 2019/02/05.
//  Copyright © 2019年 大嶋　涼. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class RecoderController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var ref: DatabaseReference!
    var bb = "0"                    //バーコードから読み取ったデータ
    var count = 0                   //インクリメント用
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Recoder")
        
        ref = Database.database().reference()
        
     
        if Int(bb) == 0{
            
            ref.child("user/note").observeSingleEvent(of: .value, with:{(snapshot) in self.count = Int((snapshot.value! as AnyObject).description)!                //noteの値の取得
                
                self.label.text = ("ノート \(self.count)冊購入")          //表示
                
            })
            
            
        }else{
            
            
            ref.child("user/data").observeSingleEvent(of: .value, with:{(snapshot) in self.count = Int((snapshot.value! as AnyObject).description)!                //noteの値の取得
                
                //
                self.count += 1                         //+1
                print (self.count)                      //確認
                let updata = ["note": self.count]       //更新用データを作る
                self.ref.child("user").updateChildValues(updata)        //元あった位置に格納
                
                let test = ["enpitu": 3]
                self.ref.child("user").updateChildValues(test)        //元あった位置に格納

                
                self.label.text = ("ノート \(self.count)冊購入")             //更新したものを表示
                
            })
        }
    }
    
    
    //
    //    //現在の購入履歴の表示
    //    func show(){
    //
    //        ref = Database.database().reference()
    //
    //        //homeから呼ばれた時
    //
    //        ref.child("user/note").observeSingleEvent(of: .value, with:{(snapshot) in self.count = Int((snapshot.value! as AnyObject).description)!                //noteの値の取得
    //
    //            self.label.text = ("ノート \(self.count)冊購入")          //表示
    //
    //        })
    //
    //
    
    
    
    
    
}
