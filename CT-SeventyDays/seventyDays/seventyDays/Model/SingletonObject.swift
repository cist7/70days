//
//  SingletonObject.swift
//  seventyDays
//
//  Created by 최일용 on 2019/12/21.
//  Copyright © 2019 CISTREE. All rights reserved.
//

import Foundation

protocol UserManagerProtocol : class {
    
}

let sharedUserManager = UserManager()

class UserManager : NSObject, UserManagerProtocol {

    var userFullName: String? = "최일용"
    var userFirstName: String? = "일용"
    var userLastName: String? = "최"
    var userNickName: String? = "그네그네"
    
    var userID: String! = "ilyong"
    
    override init() {
        
    }
}
