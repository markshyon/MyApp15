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
    
    @IBAction func doTest3(_ sender: Any) {
    }
    
    @IBAction func doTest4(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

