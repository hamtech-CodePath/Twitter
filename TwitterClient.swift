//
//  TwitterClient.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/2/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "kbt6bjzJ6pGvD0t9uN19iM3QA"
let twitterConsumerSecret = "Pv6trHdqr8QeJFT2nC6jWnST9lCK8UAE1qn8WpJbTxziGNT6u4"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
