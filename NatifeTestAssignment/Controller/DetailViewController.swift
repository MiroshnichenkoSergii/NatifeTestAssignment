//
//  DetailViewController.swift
//  NatifeTestAssignment
//
//  Created by Sergii Miroshnichenko on 26.09.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var attribute = AttributedFunctions()
    var detailItem: Post?
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var postText: UITextView!
    @IBOutlet var postTextHC: NSLayoutConstraint!
    @IBOutlet var likes: UILabel!
    @IBOutlet var currentDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = detailItem?.title
        
        guard let detailItem = detailItem else { return }

        postImage.image = UIImage(named: detailItem.image ?? "no_image")
        postText.attributedText = attribute.makeAttributedStringWithSubtitle(title: detailItem.title, subtitle: detailItem.preview_text)
        postTextHC.constant = self.postText.contentSize.height
        
        likes.text = "❤️‍🔥 \(detailItem.likes_count)"
        
        let date = Date(timeIntervalSince1970: TimeInterval(detailItem.timeshamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
        currentDate.text = formatter.string(from: date)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
