//
//  DetailsViewController.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 06/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var note:Note!
    
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let noteData = note {
            self.noteImage.makeRoundedCorners(with: 15)
            self.noteImage.image = UIImage(data: noteData.image ?? Data())
            self.dateLbl.text = noteData.date?.getDateTimeForDisplay()
            self.tagLbl.text = noteData.tags
            self.titleLbl.text = noteData.title
            self.contentLbl.text = noteData.content
        }
        
    }


}
