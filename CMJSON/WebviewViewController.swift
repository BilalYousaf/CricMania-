//
//  WebviewViewController.swift
//  CMJSON
//
//  Created by Bilal Yousaf on 14/12/2017.
//  Copyright © 2017 Bilal Yousaf. All rights reserved.
//

import UIKit

class WebviewViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    var url: String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.loadRequest(URLRequest(url:URL(string : url!)!))
        
   
    }

  
}
