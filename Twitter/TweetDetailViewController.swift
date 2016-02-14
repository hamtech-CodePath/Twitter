//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/9/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    var didFavorite: Bool?
    var didRetweet: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let tweet = tweet {
            avatarImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            userFullNameLabel.text = tweet.user?.name
            let screenname = tweet.user?.name as String!
            userScreenNameLabel.text = "@\(screenname)"
            tweetLabel.text = tweet.text
            createdAtLabel.text = tweet.createdAtString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func replyBtn(sender: AnyObject) {
        //self.performSegueWithIdentifier("detailToCompose", sender: nil)
    }
    
    @IBAction func retweetBtn(sender: AnyObject) {
        print("retweet")
        if didFavorite == true {
            didFavorite = false
            let btn = sender as! UIButton
            btn.setImage(UIImage(named: "retweet-action"), forState: .Normal)
            self.tweet!.retweetCount!--
            
        } else {
            didFavorite = true
            let btn = sender as! UIButton
            btn.setImage(UIImage(named: "retweet-action-on-pressed"), forState: .Normal)
            self.tweet!.retweetCount!++
        }
    }
 
    @IBAction func likeBtn(sender: AnyObject) {
        print("favorite")
        let btn = sender as! UIButton
        if didFavorite == true {
            didFavorite = false
            btn.setImage(UIImage(named: "like-action"), forState: .Normal)
            self.tweet!.favoriteCount!--
            
        } else {
            didFavorite = true
            btn.setImage(UIImage(named: "like-action-on-pressed"), forState: .Normal)
            self.tweet!.favoriteCount!++

        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
