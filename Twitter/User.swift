//
//  User.swift
//  Twitter
//
//  Created by Hugh A. Miles II on 2/6/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

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
}
