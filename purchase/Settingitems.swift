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


class Settingitems: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    var ref: DatabaseReference!
    var bb = "0"                    //バーコードから読み取ったデータ
    var count = 0                   //インクリメント用
    
    @IBOutlet weak var BarcodeNum: UILabel!
    
    @IBOutlet weak var RegisterBotton: UIButton!
    
    @IBOutlet weak var ItemName: UITextField!
    
    @IBOutlet weak var Price: UITextField!
    
    
    @IBAction func tapScreen(sender: UITapGestureRecognizer){
        self.view.endEditing(true)
        
    }
    
    
    
    
    @IBAction func newRegister(_ sender: Any) {
         ref = Database.database().reference()
//        ref.child("data/\(bb)").observeSingleEvent(of: .value, with:{(snapshot) in self.count = Int((snapshot.value! as AnyObject).description)!                //noteの値の取得
//
//            //
            let updata = ["name": self.ItemName.text!]       //更新用データを作る
            self.ref.child("data/\(self.bb)").updateChildValues(updata)        //元あった位置に格納
            
            let test = ["price": Int(self.Price.text!)]
            self.ref.child("data/\(self.bb)").updateChildValues(test)        //元あった位置に格納
            
            
//        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("setting")
        self.ItemName.delegate = self
        self.Price.delegate = self

        
        self.BarcodeNum.text = bb
        self.Price.keyboardType = UIKeyboardType.numberPad
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
}
