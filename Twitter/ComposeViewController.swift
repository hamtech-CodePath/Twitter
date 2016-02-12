//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/11/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var tweetInputTextField: UITextView!
    @IBOutlet weak var currentUserFullNameLabel: UILabel!
    @IBOutlet weak var currentUserScreenNameLabel: UILabel!
    @IBOutlet weak var currentUserImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
