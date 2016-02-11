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
    var refresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup delegates for tableview
        self.TweetsTblView.delegate = self
        self.TweetsTblView.dataSource = self
        
        //setup refresh to reload
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.TweetsTblView.insertSubview(refresh, atIndex: 0)
        
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
    
    //UIRefreshControl Methods
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        //Delete list completely (BAD PRACTICE) but works
        //if(onRequestView)? self.requestList = [] : self.offerList = []
        
        //Place API call for new post here then in that callback place <self.endRefreshing>
        TwitterClient.sharedInstance.homeTimelineWithCompletion(
            nil, completion: { (tweets, error) -> () in
                if(error == nil) {
                    self.tweets = tweets
                    self.TweetsTblView.reloadData()
                }
        })
        
        delay(2, closure: {
            self.refresh.endRefreshing()
        })
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
            User.currentUser?.logout()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! TweetCell //cast sender >> UICollectionCell
        let index = TweetsTblView.indexPathForCell(cell) //GetIndex that was selected
        let selectedTweet = tweets![index!.row] // getMovie from dictionary
        
        let detail = segue.destinationViewController as! TweetDetailViewController
        detail.tweet = selectedTweet
        
        
    }

}
