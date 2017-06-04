//
//  Contact.swift
//  Contacts
//
//  Created by Jeremy Hanshaw on 6/1/17.
//  Copyright © 2017 Jeremy Hanshaw. All rights reserved.
//

import UIKit

class Contact: NSObject {
    var name: String?
    var phoneNumber: String?
    
    init(name: String? = nil, phoneNumber: String? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        super.init()
    }
}
