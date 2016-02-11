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
    
    var loginCompletion: ((user:User?, error:NSError?) -> ())?
    var tweetsCompletion: ((tweets: [Tweet]?, error:NSError?) -> ())?
    
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithCompletion(params: NSDictionary?, completion: (tweets: [Tweet]?, error:NSError?) -> ()) {
        
        tweetsCompletion = completion
        
        //getTweets
        GET("1.1/statuses/home_timeline.json", parameters: params,
            success: { (operation:NSURLSessionDataTask, response:AnyObject?) -> Void in
                //helper for serialization
                print(response)
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                //send data thru completion block
                self.tweetsCompletion!(tweets:tweets, error:nil)
            }, failure: { (operation:NSURLSessionDataTask?, error:NSError) -> Void in
                print("Couldn't get tweets")
                completion(tweets: nil, error: error)
                
        })
    }
    
    func loginWithCompletion(completion: (user:User?, error:NSError?) -> ()){
        loginCompletion = completion
        //Fetch RequestToken and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Error getting request token: \(error)")
                self.loginCompletion?(user:nil, error:error)
        }
    }
    
    //TwitterClient.openURL(url: url)
    func openURL(url:NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
                print("Got access token")
            
                //Save access token
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
                //getUserInfo
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                    print("It worked!!!")
                    //setCurrentUser globally
                    var user = User.createUser(response as! NSDictionary)
                    self.loginCompletion?(user: user, error:nil)
                
                    }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                        print("Could not get User")
                        self.loginCompletion?(user:nil, error:error)
                })
            
            
            
        // Error with AccessToken
        }) { (error: NSError!) -> Void in
                print("Failed to Recieve Access Token")
                self.loginCompletion?(user:nil, error:error)
        }
    }
}
