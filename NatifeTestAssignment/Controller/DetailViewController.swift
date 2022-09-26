//
//  DetailViewController.swift
//  NatifeTestAssignment
//
//  Created by Sergii Miroshnichenko on 26.09.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var detailItem: Post?
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var postText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
