//
//  LoginModel.swift
//  Demo
//
//  Created by Apple on 2020/1/19.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit
import HandyJSON

class LoginModel: HandyJSON {
    required init() {}
    

    var status: Int?
    var msg: String?
    
    var result: LoginResutlMode?
}

class LoginResutlMode: HandyJSON {
    required init() {}
    
    var role: LoginRoleModel?
    var user: UserModel?
}

class LoginRoleModel: HandyJSON {
    required init() {}
    var parent: Int?
}

class UserModel: HandyJSON {
    required init() {}
    var dev_type: Int?
    var time_add: String?
    var time_update: String?
    var token: String?
    var user_head: String?
    var user_id: String?
    var user_idcode: String?
    var user_name: String?
    var user_phont: String?
    var user_post_address: String?
    var user_post_name: String?
    var user_post_phone: String?
}
