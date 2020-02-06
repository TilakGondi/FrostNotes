//
//  AddViewController.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 06/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//  PENDING FEATURES:
//  1: Make the View to scroll when the keyboard is presented , hence the add operation can be verified only from the Simulator now.
//  2: Chacking the permission to access the gallery to add media.

import UIKit

class AddViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var noteTitleTxt: UITextField!
    @IBOutlet weak var tagsTxt: UITextField!
    @IBOutlet weak var noteTxtView: UITextView!
    
    private var newNote = Note()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Create a new note"
        label.font = .boldSystemFont(ofSize: 18)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+100)
        self.scrollView.isScrollEnabled = true
        self.scrollView.delegate = self
        
    }
    
    @IBAction func cancleAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func attachMedia(_ sender: Any) {
        self.showImageGallery()
    }
    
    //To add the new note
    @IBAction func addnewNote(_ sender: Any) {
        
        newNote.title = self.noteTitleTxt.text
        newNote.tags = self.tagsTxt.text
        newNote.date = Date()
        newNote.content = self.noteTxtView.text
        // Insert the newNote in to DB.
        if DBHandler.shared.insert(note: newNote) {
            print("New note created Successfully")
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: IMAGE PICKER, Delegate, Datasource.
extension AddViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    //To present the image picker gallery
    func showImageGallery() {
  
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let mediaPickerController = UIImagePickerController()
            mediaPickerController.delegate = self
            mediaPickerController.allowsEditing = true
            mediaPickerController.mediaTypes = ["public.image", "public.movie"]
            mediaPickerController.sourceType = .photoLibrary
            mediaPickerController.allowsEditing = false
            self.present(mediaPickerController, animated: true, completion: nil)
        }else{
            print("Source Media library is missing!")
        }
    }
    //To get the selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        let pngData = image.pngData()
        newNote.image = pngData
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
}
