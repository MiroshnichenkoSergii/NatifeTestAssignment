//
//  Cell.swift
//  NatifeTestAssignment
//
//  Created by Sergii Miroshnichenko on 27.09.2022.
//

import UIKit

class Cell: UITableViewCell {
    var table = TableViewController()

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var lastDateLabel: UILabel!
    
    @IBOutlet var dynamicViewButton: UIButton!
    
    @IBAction func tap(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
           animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            sender.transform = .identity
        })
        subtitleLabel.numberOfLines = .max
        sender.titleLabel?.text = "Collapse"
        table.tableView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
