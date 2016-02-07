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
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    
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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func pressedRetweet(sender: AnyObject) {
        print("retweet")
        if didFavorite == true {
            didFavorite = false
            self.retweetImageView.image = UIImage(named:"retweet-action")
            self.tweet.retweetCount!--
            retweetCountLabel.text = String(tweet.retweetCount!)

        } else {
           didFavorite = true
            self.retweetImageView.image = UIImage(named:"retweet-action-on-pressed")
            self.tweet.retweetCount!++
            retweetCountLabel.text = String(tweet.retweetCount!)
        }
    }

    @IBAction func pressedFavorite(sender: AnyObject) {
        print("favorite")
        if didFavorite == true {
            didFavorite = false
            self.favoriteImageView.image = UIImage(named:"like-action")
            self.tweet.favoriteCount!--
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            
        } else {
            didFavorite = true
            self.favoriteImageView.image = UIImage(named:"like-action-on-pressed")
            self.tweet.favoriteCount!++
            favoriteCountLabel.text = String(tweet.favoriteCount!)
        }
    }
}
