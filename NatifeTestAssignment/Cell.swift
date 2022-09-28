//
//  Cell.swift
//  NatifeTestAssignment
//
//  Created by Sergii Miroshnichenko on 27.09.2022.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var lastDateLabel: UILabel!
    @IBOutlet var dynamicViewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
