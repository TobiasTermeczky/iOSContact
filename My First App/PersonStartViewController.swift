//
//  PersonStartViewController.swift
//  My First App
//
//  Created by Tobias Termeczky on 28/08/2017.
//  Copyright © 2017 Tobias Termeczky. All rights reserved.
//

import UIKit
import Darwin

class PersonStartViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = "Harold"
        lastNameLabel.text = "Stock"
        button.setTitle("Refresh", for: .normal)
        
        if let image = UIImage(named: "Person"){
            photoImageView.image = image
        }
        
        if let image = UIImage(named: "Clouds"){
            backgroundImageView.image = image
        }

        uiStyling()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeName(_ sender: UIButton) {
        let postEndpoint: String = "https://randomuser.me/api/"
        let session = URLSession.shared
        let url = URL(string: postEndpoint)!
        
        session.dataTask(with: url, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let realResponse = response as? HTTPURLResponse, realResponse.statusCode == 200 else {
                print("Not a 200 response")
                return
            }

            let json = try! JSONSerialization.jsonObject(with: data!) as? [String: Any]
            let results = json?["results"] as? [[String: Any]]
            
            for result in results!{
                let name = result["name"] as? [String: Any]
                let firstName = name?["first"] as? String
                let lastName = name?["last"] as? String
                let picture = result["picture"] as? [String: Any]
                let profilePhoto = picture?["large"] as? String
                DispatchQueue.main.async(execute: {
                    self.handleNewUser(firstName: firstName!, lastName: lastName!, profilePhoto: profilePhoto!)
                })
                
            }
        }).resume()
    }
    
    func handleNewUser(firstName: String, lastName: String, profilePhoto: String){
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        if let checkedUrl = URL(string: profilePhoto) {
            downloadImage(url: checkedUrl)
        }    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.photoImageView.image = UIImage(data: data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func uiStyling(){
        photoImageView.layer.cornerRadius = 50
        photoImageView.layer.borderColor = UIColor.white.cgColor
        photoImageView.layer.borderWidth = 5.0
        photoImageView.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
