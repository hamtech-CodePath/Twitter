//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/6/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    @IBAction func onLogout(sender: AnyObject) {
            User.currentUser?.logout()
    }
}
