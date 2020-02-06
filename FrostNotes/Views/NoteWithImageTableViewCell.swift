//
//  NoteWithImageTableViewCell.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 06/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class NoteWithImageTableViewCell: UITableViewCell {
    

    
    @IBOutlet weak var bgCellView:UIView!
    @IBOutlet weak var dateLbl:UILabel!
    @IBOutlet weak var tagsLbl:UILabel!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var contentLbl:UILabel!
    @IBOutlet weak var noteMediaImage:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
