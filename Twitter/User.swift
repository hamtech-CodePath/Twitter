//
//  User.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/6/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "curUserKey"
let userDidLoginNotification = "userDidLoginNotif"
let userDidLogoutNotification = "userDidLogoutNotif"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagLine: String?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary //save whole JSON Dictionary
        
        //assign serialized data to object variables
        name = dictionary["name"] as? String
        screenname = dictionary["screenname"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get{
            if _currentUser == nil {

                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
        
                do {
                    let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
        
                    }  catch let error as NSError {
                        //handle error
                        print("Error : \(error)")
                    }
                }
            }
        
            return _currentUser
        }
        
        set(user){
            _currentUser = user
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions(rawValue: 0))
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                }   catch let error as NSError {
                    //handle error
                    print("Error : \(error)")
                }
            
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
}
