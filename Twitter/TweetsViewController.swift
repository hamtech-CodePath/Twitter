//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/6/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(
            nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
        })
    }
    
    @IBAction func onLogout(sender: AnyObject) {
            User.currentUser?.logout()
    }
}
