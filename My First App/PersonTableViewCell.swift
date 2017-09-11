//
//  PersonTableViewCell.swift
//  iOsContact
//
//  Created by Tobias Termeczky on 11/09/2017.
//  Copyright © 2017 Tobias Termeczky. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        personImageView.layer.cornerRadius = 20
        personImageView.layer.borderColor = UIColor.black.cgColor
        personImageView.layer.borderWidth = 1.0
        personImageView.clipsToBounds = true
        personImageView.alpha = 0.1
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {self.personImageView.alpha = 1.0},
                       completion: {isDone in print("IsDone: "+String(isDone))})
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
