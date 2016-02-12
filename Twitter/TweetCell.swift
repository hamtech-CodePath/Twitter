//
//  TweetCell.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/7/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var TweetLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    
    var didFavorite: Bool?
    var didRetweet: Bool?
    
    var tweet: Tweet! {
        didSet{
            avatarImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            userFullNameLabel.text = tweet.user?.name
            let screenname = tweet.user?.name as String!
            userScreenNameLabel.text = "@\(screenname)"
            TweetLabel.text = tweet.text
            createdAtLabel.text = tweet.createdAtString
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            retweetCountLabel.text = String(tweet.retweetCount!)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Initialization code
        avatarImageView.layer.cornerRadius = 10
        avatarImageView.clipsToBounds = true
        didFavorite = false
        didRetweet = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func pressedRetweet(sender: AnyObject) {
        print("retweet")
        if didFavorite == true {
            didFavorite = false
            let btn = sender as! UIButton
            btn.setImage(UIImage(named: "retweet-action"), forState: .Normal)
            self.tweet.retweetCount!--
            retweetCountLabel.text = String(tweet.retweetCount!)

        } else {
           didFavorite = true
            let btn = sender as! UIButton
            btn.setImage(UIImage(named: "retweet-action-on-pressed"), forState: .Normal)
            self.tweet.retweetCount!++
            retweetCountLabel.text = String(tweet.retweetCount!)
        }
    }

    @IBAction func pressedFavorite(sender: AnyObject) {
        print("favorite")
        let btn = sender as! UIButton
        if didFavorite == true {
            didFavorite = false
            btn.setImage(UIImage(named: "like-action"), forState: .Normal)
            self.tweet.favoriteCount!--
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            
        } else {
            didFavorite = true
            btn.setImage(UIImage(named: "like-action-on-pressed"), forState: .Normal)
            self.tweet.favoriteCount!++
            favoriteCountLabel.text = String(tweet.favoriteCount!)
        }
    }
}
