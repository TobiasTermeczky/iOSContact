//
//  PersonStartViewController.swift
//  My First App
//
//  Created by Tobias Termeczky on 28/08/2017.
//  Copyright © 2017 Tobias Termeczky. All rights reserved.
//

import UIKit
import Darwin



class PersonDetailViewController: UIViewController {
    
    var person : Person?
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "" + (person?.firstName?.capitalized)! + "'s Details";
        firstNameLabel.text = person?.firstName?.capitalized
        lastNameLabel.text = person?.lastName?.capitalized
        photoImageView.image = person?.profilePhoto
        
        if let image = UIImage(named: "Clouds"){
            backgroundImageView.image = image
        }

        uiStyling()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func uiStyling(){
        photoImageView.layer.cornerRadius = 50
        photoImageView.layer.borderColor = UIColor.white.cgColor
        photoImageView.layer.borderWidth = 5.0
        photoImageView.clipsToBounds = true
    }
    
}
