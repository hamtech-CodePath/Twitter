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
    
    var tweet: Tweet! {
        didSet{
            avatarImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            userFullNameLabel.text = tweet.user?.name
            let screenname = tweet.user?.name as String!
            userScreenNameLabel.text = "@\(screenname)"
            TweetLabel.text = tweet.text
            createdAtLabel.text = tweet.createdAtString
            
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

}
