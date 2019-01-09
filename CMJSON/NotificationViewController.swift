//
//  NotificationViewController.swift
//  CMJSON
//
//  Created by Bilal Yousaf on 03/01/2018.
//  Copyright © 2018 Bilal Yousaf. All rights reserved.
//

import UIKit

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //1. Req Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted, error) in
            
            if granted {
                print ("Notifictaion granted ")
                
            }else {
                print (error?.localizedDescription)
            }
        })
        
        
}
    
    
    @IBAction func notifyButtonTapped(_ sender: UIButton) {
        scheduleNotificatio(inSeconds: 5, completion: { sucess in
            if sucess {
                print ("Sucessful ")
                
            }else {
                print ("kdsfkjds")
            }
            
        })
        
    }
    
    func scheduleNotificatio (inSeconds: TimeInterval, completion: @escaping (_ Sucess : Bool)->()) {
        
        let notif = UNMutableNotificationContent ()
        
        notif.title = "New Notification"
        notif.subtitle = "These are The latest Fixtures"
        notif.body = "The New latest Fixtures have arrived plesse check them"
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval : inSeconds, repeats: false)
        
        let request = UNNotificationRequest (identifier: "myNotification" ,content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print (error)
                completion(false)
            }else {
                completion(true )
            }
            
        })
        
        
        
    }
    
    
    
    
}
