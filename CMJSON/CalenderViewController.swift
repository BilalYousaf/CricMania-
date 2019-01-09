//
//  CalenderViewController.swift
//  CMJSON
//
//  Created by Bilal Yousaf on 02/01/2018.
//  Copyright © 2018 Bilal Yousaf. All rights reserved.
//

import UIKit
import UserNotifications

class CalenderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var matches: [Live]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCalender ()
        
      
    }
    func fetchCalender () {
        
        let urlRequest  = URLRequest (url : URL(string: "http://cricapi.com/api/matchCalendar/w93Wi5KvcLZkYPyPZi94CWaoRCj2")!)
      
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return

            }
            
            self.matches = [Live]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let matchesFromJSon = json ["data"] as? [[String : AnyObject]]
                {
                    for matchFromJSon in matchesFromJSon {
                        let match = Live ()
                        if let name = matchFromJSon["name"] as? String, let date = matchFromJSon["date"] as? String {
                            
                            match.date = date
                            match.name = name
                        }
                       self.matches?.append(match)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
           
                
            }catch let error{
                print (error)
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calenderCell", for: indexPath) as! CalenderCell
        
        cell.name.text = self.matches?[indexPath.item].name
        cell.date.text = self.matches?[indexPath.item].date
        
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matches?.count ?? 0
        
    }
    
}

