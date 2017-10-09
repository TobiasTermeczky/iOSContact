//
//  Person.swift
//  iOsContact
//
//  Created by Tobias Termeczky on 11/09/2017.
//  Copyright © 2017 Tobias Termeczky. All rights reserved.
//

import UIKit

class Person: NSObject {
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var profilePhoto: UIImage?
    
    required init(firstname: String, lastname: String, email: String, phone: String, image: UIImage) {
        self.firstName = firstname
        self.lastName = lastname
        self.email = email
        self.phone = phone
        profilePhoto = image
    }
}
