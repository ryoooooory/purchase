//
//  CameraController.swift
//  Purchase
//
//  Created by 大嶋　涼 on 2019/02/05.
//  Copyright © 2019年 大嶋　涼. All rights reserved.
//

import UIKit
import AVFoundation             //クラスの集合体


class CameraController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    var barcode = ""                        //読み取ったコードの値を代入
    let session = AVCaptureSession()
    var camera:AVCaptureDevice!
    var captureSession: AVCaptureSession!      //カメラセッション
    var cameraDevices: AVCaptureDevice!           //デバイス
    var imageOutput: AVCaptureStillImageOutput!           //画像のアウトプット
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //セッションの設定
        captureSession = AVCaptureSession()
        
        //デバイスの設定
        let devices = AVCaptureDevice.devices()         //AVCaptureDeviceのメソッド?
        for device in devices {                         //デバイス一覧からバックカメラをcameraDevicesに格納
            if device.position == AVCaptureDevice.Position.back {
                cameraDevices = device as! AVCaptureDevice      //見つけたらかダウンキャスティング
            }
        }
        
        //inputの設定
        let Input: AVCaptureInput!
        do {                                                                                //バックカメラをInputに設定
            Input = try AVCaptureDeviceInput.init(device: cameraDevices)           //デバイスからデータを取得
        } catch {
            Input = nil
        }
        captureSession.addInput(Input)                          //セッションに追加
        
        
        
        
        //    カメラが写す映像を表示するレイヤーを生成
        let captureVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        captureVideoLayer.frame = self.view.bounds
        captureVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(captureVideoLayer)         //Viewに追加、つまりカメラが取得したデータを画面に表示
        
        
        
        
        
        
        
        //     outputの設定
        let output = AVCaptureMetadataOutput()         //初期化、メタデータか型
        captureSession?.addOutput(output)                   //セッションにoutputを追加
        output.setMetadataObjectsDelegate(self as? AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main)                   //deligateを設定
        output.metadataObjectTypes = [.ean13]                //取得するmetaの種類
        
        let x: CGFloat = 0.1
        let y: CGFloat = 0.4
        let width: CGFloat = 0.8
        let height: CGFloat = 0.2
        output.rectOfInterest = CGRect(x: y, y: 1 - x - width, width: height, height: width)            //カメラが写す映像の中からメタデータを取得する範囲
        
        //metaデータを取得する場所を可視化
        let borderView = UIView(frame: CGRect(x: view.frame.size.width * x, y: view.frame.size.height * y, width: view.frame.size.width * width, height: view.frame.size.height * height))
        //        borderView.frame = CGRect(x: view.frame.size.width * x, y: view.frame.size.height * y, width: view.frame.size.width * width, height: view.frame.size.height * height)
        //
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(borderView)
        
        
        
        
        
        
        //セッション開始
        captureSession.startRunning()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print("camera")
        
        
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // バーコードの内容が空かどうかの確認
            if metadata.stringValue == nil { continue }
            
            // 読み取ったデータの値
            print(metadata.type)
            print(metadata.stringValue!)
            barcode = metadata.stringValue!
            
            
            //ダイアログ表示
            let alert: UIAlertController = UIAlertController(title: "ノート", message: "購入しますか？", preferredStyle:  UIAlertController.Style.alert)
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Yes")
                
                //RecoderControllerに遷移
                self.changeView()
            })
            // キャンセルボタン
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("No")
            })
            // UIAlertControllerにActionを追加
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            
            //
            //Alertを表示
            present(alert, animated: true, completion: nil)
            
            
        }
    }
    
    
    //segueでRecoderControllerに遷移
//    func changeView() {
//        self.performSegue(withIdentifier: "toRecoder2", sender: nil)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "toRecoder2") {
//            let vc2: RecoderController = (segue.destination as? RecoderController)!
//            // ViewControllerのtextVC2にメッセージを設定
//            vc2.bb = barcode                    //取得したbarcodeを渡す
//        }
//    }
    
    //segueでRecoderControllerに遷移
    func changeView() {
        self.performSegue(withIdentifier: "toListviewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toListviewController") {
            let vc2: ListviewController = (segue.destination as? ListviewController)!
            // ViewControllerのtextVC2にメッセージを設定
            vc2.barcode = barcode                    //取得したbarcodeを渡す
            print(barcode)
        }
    }
    
    
    
    
}

