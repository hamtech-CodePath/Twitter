//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/6/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]?
    
    @IBOutlet weak var TweetsTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup delegates for tableview
        self.TweetsTblView.delegate = self
        self.TweetsTblView.dataSource = self
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(
            nil, completion: { (tweets, error) -> () in
            if(error == nil) {
                self.tweets = tweets
                self.TweetsTblView.reloadData()
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(
            nil, completion: { (tweets, error) -> () in
                if(error == nil) {
                    self.tweets = tweets
                    self.TweetsTblView.reloadData()
                }
        })
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.tweets != nil {
            return (self.tweets?.count)!
        } else {
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as? TweetCell
        
        cell?.tweet = tweets![indexPath.row]
        
        return cell!
    }
    
    @IBAction func onLogout(sender: AnyObject) {
            User.currentUser?.logout()
    }
    @IBAction func onRetweetTap(sender: AnyObject) {
        print("retweet")
    }

}
