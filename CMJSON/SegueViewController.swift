//
//  SegueViewController.swift
//  CMJSON
//
//  Created by Bilal Yousaf on 02/01/2018.
//  Copyright © 2018 Bilal Yousaf. All rights reserved.
//

import UIKit

import UIKit

class SegueViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tableArray = ["Schedules", "News" , "Calender"]
    var segueIdentifiers  = ["A", "B", "C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return tableArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
    }
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers [indexPath.row], sender: self)
    }
    
}
