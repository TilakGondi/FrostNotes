//
//  FilterViewController.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 06/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var filterTable: UITableView!
    @IBOutlet weak var clearBtn: UIBarButtonItem!
    
    fileprivate let sections = ["Sort by"]
    fileprivate let filterByArray = ["Date"]
    private let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clearFilters(_ sender: Any) {
        userDefaults.set(false, forKey: "FilterByDate")
        self.filterTable.reloadData()
        clearBtn.isEnabled = false
    }
    

}


extension FilterViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterByArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = filterByArray[indexPath.row]
            if userDefaults.bool(forKey: "FilterByDate") {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if userDefaults.bool(forKey: "FilterByDate") {
                    userDefaults.set(false, forKey: "FilterByDate")
                    cell?.accessoryType = .none
                    clearBtn.isEnabled = false
                }else{
                    userDefaults.set(true, forKey: "FilterByDate")
                    cell?.accessoryType = .checkmark
                    clearBtn.isEnabled = true
                }
            }
        default:
            print("default")
        }
    }
    
    
}
