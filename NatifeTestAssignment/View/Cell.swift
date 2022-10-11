//
//  Cell.swift
//  NatifeTestAssignment
//
//  Created by Sergii Miroshnichenko on 27.09.2022.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var lastDateLabel: UILabel!
    @IBOutlet weak var dynamicViewButton: UIButton!
    
    var numberOfLines: Int = 2
    
    var buttonTitle: String = "Expand"
    
    var isCellExpanded: Bool = false {
        didSet {
            numberOfLines = isCellExpanded ? 0 : 2
            buttonTitle = isCellExpanded ? "Collapse" : "Expand"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Button view settings
        dynamicViewButton.layer.cornerRadius = 5
        dynamicViewButton.layer.borderWidth = 1
        dynamicViewButton.layer.borderColor = UIColor.systemBlue.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

