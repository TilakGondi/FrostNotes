//
//  NotesViewController.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 06/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//
// PENDING FEATURE IMPLEMENTATIONS:
// 1: Search notes by title, The search predicate is created in the DB handler, and the method to fetch the results from the db based on the search term is available in the NotesViewModel class.
// 2: Filtering by dates is also partially implemented, as the calculation of time logic is not yet implemented when performing the fetch from db.
// 3: Autolayout support for all the screen sizes and orientations is not completely implemented.

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var notesTable: UITableView!
    let addBtn = UIButton(type: .custom)
    var selectedNote:Note?
    
    //Datasource for the table in this viewController
    let dataSrc = NotesListDataSource()
    
    //ViewModel for the this viewController
    lazy var viewModel: NotesViewModel = {
        let viewModel = NotesViewModel(dataSource: dataSrc)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isToolbarHidden = false
        // Fetch the notes from the db on loading the app.
        self.viewModel.loadNotesListFromDB()
        self.notesTable.dataSource = self.dataSrc
        self.notesTable.delegate = self
        //To add the observer/notifier on the datasource values to trigger the notes table view reload when the notes are fetched from the DB.
        self.dataSrc.data.addAndNotify(obsrv: self) { [weak self] in
            self?.notesTable.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "NoteDetails":
            let detailVC:DetailsViewController = segue.destination as! DetailsViewController
//            set the selected note to the note object in details view controller
            detailVC.note = self.selectedNote
            break
        default:
            print("default segue in NotesViewController")
        }
    }
}


extension NotesViewController{
    func setUpNavigationControllerUI() {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Notes"
        label.font = .boldSystemFont(ofSize: 18)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)

        addBtn.frame = CGRect(x: (self.view.frame.size.width/2)-50, y: self.view.frame.size.height-130, width: 100, height: 100)
        addBtn.setImage(UIImage(named: "add_note"), for: .normal)
        self.view.bringSubviewToFront(addBtn)
        addBtn.addTarget(self, action: #selector(addNewnote), for: .touchUpInside)
        //Iam using this depricated way of adding the floating button as i have used this earlier in my previously worked projects. Due to time constraints at my end, did not find the recommended way to implement this (I believe this could be achieved by other ways).
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(addBtn)
        }
    }
    
    //Action on taping the floating add new note button.
    @objc func addNewnote()  {
        self.performSegue(withIdentifier: "AddNote", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Refresh the list with any new additions to the db.
        self.viewModel.loadNotesListFromDB()
        //to put back the floating button and the left alligned title in the navigation bar view
        setUpNavigationControllerUI()
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //To remove the floating add button.
        addBtn.removeFromSuperview()
    }
}


extension NotesViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //To get the note object on taping the note and navigating to details page
        self.selectedNote = self.dataSrc.data.value[indexPath.row]
        self.performSegue(withIdentifier: "NoteDetails", sender: self)
    }
}
