//
//  ViewController.swift
//  MyApp15
//
//  Created by Shang Chi Cheng on 2017/9/26.
//  Copyright © 2017年 shyon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tabView: UITableView!
    
    
   
    
    
    @IBAction func doTest1(_ sender: Any) {
        
        let url = URL(string: "http://www.iii.org.tw")
        do {
            let content = try String(contentsOf: url!)
            print(content)
        }catch {
            print("Error")
        }
    }
   
    @IBAction func doTest2(_ sender: Any) {
        
        let url = URL(string: "http://i2.cdn.cnn.com/cnnnext/dam/assets/170908160636-nk-icbm-5-large-tease.jpg")
        do{
            let data = try Data(contentsOf: url!)
            let img = UIImage(data: data)
            imgView.image = img
            print("OK")
        }catch {
            print("Error2")
        }
        
    }
    
    private var q1 = DispatchQueue(label: "tw.com.mark.queue.q1", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent)
    @IBAction func doTest3(_ sender: Any) {
        q1.async {
            self.test3()
        }
    }
    private func test3() {
        let url = URL(string: "http://i2.cdn.cnn.com/cnnnext/dam/assets/170908160636-nk-icbm-5-large-tease.jpg")
        do{
            let data = try Data(contentsOf: url!)
            let img = UIImage(data: data)
            
            DispatchQueue.main.async {  //背景轉前景執行，重要！
                self.imgView.image = img
            }
            
            print("OK")
        }catch {
            print("Error2")
        }
    }
    
    @IBAction func doTest4(_ sender: Any) { //依賴網際網路時，建議用這種方式。
        let url = URL(string: "http://www.pchome.com.tw")
        
//        let config = URLSessionConfiguration.default    //使用cache，資料一樣時就不會重抓
        let config = URLSessionConfiguration.ephemeral    //不存cache
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard error == nil else {return}
            if let cont = String(data: data!, encoding: String.Encoding.utf8) {
                print(cont)
            }
        }
        task.resume()   //重要！不能忘記跑這一列執行！
    }
    
    //session downloadTask
    @IBAction func doTest5(_ sender: Any) {
        let url = URL(string: "http://www.iii.org.tw")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.downloadTask(with: url!) { (url2, response, error) in
            print("--------------")
            print(url2!)
            do{
                let cont = try String(contentsOf: url2!)
                print("--------------")
                print(cont)
            }catch {
                print("Error3")
            }
            
        }
        task.resume()
    }
    
    @IBAction func doTest6(_ sender: Any) {
        let url = URL(string: "http://data.coa.gov.tw/Service/OpenData/ODwsv/ODwsvAttractions.aspx")
        do {
            let data = try Data(contentsOf: url!)
            let cont = String(data: data, encoding: String.Encoding.utf8)
            print(cont!)

            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                //json is a Any
                //json as! [[String:String]] => because Data Source
                for row in json as! [[String:String]] {   //關鍵：要把json轉成我要的型別
                    print("\(row["Name"]!) : \(row["Tel"]!)")
                }
            }
            
            
        }catch {
            print("Error4")
        }
    }
    
    
    private let fmgr = FileManager.default
    @IBAction func doTest7(_ sender: Any) {
        
        let url = URL(string: "http://www.iii.org.tw")  //也適用於jpg/pdf...等，一招打全部
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //以下為一個任務
        
//        let task2 = session.downloadTask(with: url!) { (url, response, error) in
//            <#code#>
//        }
        
        let task = session.downloadTask(with: url!) { (url, response, error) in
            guard error == nil else{return}
            
            do{
                let targetURL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/brad.html")
                try self.fmgr.copyItem(at: url!, to: targetURL)
                print("copy success")
            }catch {
                print("Error6")
            }
            
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

