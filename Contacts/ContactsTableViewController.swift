//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Jeremy Hanshaw on 5/22/17.
//  Copyright © 2017 Jeremy Hanshaw. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contacts:[Contact] = []
    var moveButton: UIBarButtonItem?
    var doneButton: UIBarButtonItem?
    var addButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ContactsTableViewController.toggleEdit))
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ContactsTableViewController.toggleEdit))
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ContactsTableViewController.addContact))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = moveButton
        
        let jake = Contact(name: "Jake the Snake", phoneNumber: "309-555-1234")
        let ashley = Contact(name: "Ashley")
        let aaron = Contact(phoneNumber: "309-555-9876")
        let claire = Contact(name: "Claire Bear")
        
        contacts.append(jake)
        contacts.append(ashley)
        contacts.append(aaron)
        contacts.append(claire)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func toggleEdit() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing {
            //self.editButtonItem.title = "Done"
            //moveButton!.style = .done
            navigationItem.leftBarButtonItem = doneButton
        } else {
            //self.editButtonItem.title = "Edit2"
            //moveButton!.style = .plain
            navigationItem.leftBarButtonItem = moveButton
        }
    }

    func addContact() {
        let newContact = Contact(name: "New Contact")
        self.contacts.append(newContact)
        let newIndexPath = IndexPath(row: self.contacts.count - 1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contact = self.contacts[indexPath.row]
        
        if let name = contact.name {
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = "No Name"
        }

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let contactMoving = contacts.remove(at: fromIndexPath.row)
        contacts.insert(contactMoving, at: to.row)
    }
 
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        let contact = self.contacts[indexPath!.row]
        let destination = segue.destination as! DetailViewController
        destination.contact = contact
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
