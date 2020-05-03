//
//  ViewController3.swift
//  AdoreBell
//
//  Created by Muhammed Elsayed on 3/11/18.
//  Copyright © 2018 Muhammed Elsayed All rights reserved.
//

import UIKit
import WebKit

class ViewController3: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "http://71.41.187.131:1024/-wvhttp-01-/GetOneShot?image_size=640x480&frame_count=1000000000#.WqasX_T4Gkg.link")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
