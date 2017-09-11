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
    var profilePhoto: UIImage?
    
    required init(firstname: String, lastname: String, image: UIImage) {
        self.firstName = firstname
        self.lastName = lastname
        profilePhoto = image
    }
}
