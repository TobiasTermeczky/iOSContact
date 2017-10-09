//
//  PersonTableViewController.swift
//  My First App
//
//  Created by Tobias Termeczky on 04/09/2017.
//  Copyright © 2017 Tobias Termeczky. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
    var persons: [Person] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        getPersons()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPersons(){
        let postEndpoint: String = "https://randomuser.me/api/?results=20"
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
                let email = result["email"] as? String
                let phone = result["phone"] as? String
                let picture = result["picture"] as? [String: Any]
                let profilePhoto = picture?["large"] as? String
                DispatchQueue.main.async(execute: {
                    DispatchQueue.global().async {
                        let url = profilePhoto;
                        let data = try? Data(contentsOf: URL(string: url!)!);
                        DispatchQueue.main.async {
                            let profileImage = UIImage(data: data!)
                            let p1 = Person(firstname: firstName!, lastname: lastName!, email: email!, phone: phone! ,image: profileImage!)
                            self.persons.append(p1)
                            self.tableView.reloadData()
                        }
                    }
                })
                
            }
        }).resume()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        
        let row = indexPath.row
        print(persons)
        cell.fullNameLabel?.text = persons[row].firstName!.capitalized + " " + persons[row].lastName!.capitalized;
        cell.personImageView.image = persons[row].profilePhoto;
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    @IBAction func btnClick(_ sender: Any){
        self.performSegue(withIdentifier: "seguesPersonTableToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "personDetails" {
            if let destination = segue.destination as? PersonDetailViewController{
                let index = self.tableView.indexPathForSelectedRow?.row
                let person = self.persons[index!]
                destination.person = person
            }
        }
    }

}
