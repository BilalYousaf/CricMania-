//
//  ViewController.swift
//  CMJSON
//
//  Created by Bilal Yousaf on 06/12/2017.
//  Copyright © 2017 Bilal Yousaf. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    
    @IBOutlet weak var tableview: UITableView!
    
    var articless: [Article]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticles()
    }
    
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=espn-cric-info&apiKey=d8f93a736f9348a1b5ce67b39c520637")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            self.articless = [Article]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                print ("Returned JSON = \(json)")
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["title"] as? String, /*let author = articleFromJson["author"] as? String, */ let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String {
                            
                           // article.author = "Bilal Yousaf"
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageUrl = urlToImage
                        }
                        self.articless?.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as!ArticleCell
        
        cell.title.text = self.articless?[indexPath.item].headline
        cell.desc.text = self.articless?[indexPath.item].desc
        //cell.author.text = self.articles?[indexPath.item].author
        cell.imgView.downloadImage(from: (self.articless?[indexPath.item].imageUrl!)!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articless?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web")as! WebviewViewController
        
        
        
        webVC.url = self.articless?[(tableview.indexPathForSelectedRow?.row)!].url
        self.present(webVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func Share(_ sender: Any) {
        
        let selectServiceAlert = UIAlertController(title: "Select Social Media", message: "Select your choice:", preferredStyle: .actionSheet)
        
        //Create action
        let facebookActionButton = UIAlertAction(title: "Facebook", style: .default) { (action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                
                // Create Post
                let FacebookPostView = SLComposeViewController (forServiceType: SLServiceTypeFacebook)
                
                //Set default
                FacebookPostView?.setInitialText("Share this article!")
                
                //Display post
                self.present(FacebookPostView!, animated: true, completion: nil)
            } else{
                self.error(serviceType: "Facebook")
                
            }
    
    
    
    
        }
       
        //Create action
        let TwitterActionButton = UIAlertAction(title: "Twitter", style: .default) { (action) in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                
                // Create Post
                let twitterPostView = SLComposeViewController (forServiceType: SLServiceTypeTwitter)
                
                //Set default
                twitterPostView?.setInitialText("Share this article!")
                
                //Display post
                self.present(twitterPostView!, animated: true, completion: nil)
            } else{
                self.error(serviceType: "Twitter")
                
            }
            
            
            
            
        }
        let cancelActionButton = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        //add actions to alert
        selectServiceAlert.addAction(facebookActionButton)
        selectServiceAlert.addAction(TwitterActionButton)
        selectServiceAlert.addAction(cancelActionButton)
        
        //Display the alert
        self.present(selectServiceAlert, animated: true, completion: nil)
   
    }
   
    
    func  error (serviceType: String){
        let errorAlert = UIAlertController(title: "Unavailable", message: "Device is not connected to \(serviceType)", preferredStyle: .alert)
        //create action
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        errorAlert.addAction(okAction)
        
        
        //display
        self.present(errorAlert, animated: true, completion: nil)
        
                                     
    }
    
        
   }

extension UIImageView {
    
    func downloadImage(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

















