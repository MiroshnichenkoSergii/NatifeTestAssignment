//
//  ViewController.swift
//  NatifeTestAssignment
//
//  Created by Sergii Miroshnichenko on 26.09.2022.
//

import UIKit

class TableViewController: UITableViewController {
    var attribute = AttributedFunctions()
    var posts = [Post]()
    
    var toggle: Bool = false
    var all: Bool = false
    var senderTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Natife Posts List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(filter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Expand All", style: .plain, target: self, action: #selector(expandAll))
        
        tableView.rowHeight = UITableView.automaticDimension
        
        let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
        
        DispatchQueue.global().async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    
                    DispatchQueue.main.async {
                        self.parse(json: data)
                        return
                    }
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let post = posts[indexPath.row]
        
        cell.titleLabel.attributedText = attribute.makeAttributedTitle(title: post.title)
        cell.subtitleLabel.attributedText = attribute.makeAttributedSubtitle(subtitle: post.preview_text)
        cell.subtitleLabel.tag = indexPath.row
        
        if toggle {
            if indexPath.row == senderTag {
                cell.subtitleLabel.numberOfLines = .max
                cell.dynamicViewButton.titleLabel?.text = "Collapse"
            } else if all {
                cell.subtitleLabel.numberOfLines = .max
                cell.dynamicViewButton.titleLabel?.text = "Collapse"
            }
        } else {
            cell.subtitleLabel.numberOfLines = 2
            cell.dynamicViewButton.titleLabel?.text = "Expand"
        }
        
        cell.likesLabel.text = "❤️‍🔥 \(post.likes_count)"
        
        let nowDate: Date
        if #available(iOS 15, *) {
            nowDate = Date.now
        } else {
            nowDate = Date(timeIntervalSinceNow: 0)
        }
        
        let postingDate = Date(timeIntervalSince1970: TimeInterval(post.timeshamp))
        let diff = Calendar.current.dateComponents([.day], from: postingDate, to: nowDate).day
        
        cell.lastDateLabel.text = "\(diff ?? 0)" + " days ago"
        
        //button
        cell.dynamicViewButton.layer.cornerRadius = 5
        cell.dynamicViewButton.layer.borderWidth = 1
        cell.dynamicViewButton.layer.borderColor = UIColor.systemBlue.cgColor
        cell.dynamicViewButton.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.detailItem = posts[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tap(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
           animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            sender.transform = .identity
        })
        toggle.toggle()
        senderTag = sender.tag
        tableView.reloadData()
    }
    
    @objc func expandAll() {
        all.toggle()
        toggle.toggle()
        tableView.reloadData()
    }
    
    @objc func filter() {
        let ac = UIAlertController(title: "Choose option", message: nil, preferredStyle: .alert)

        //sort by date
        ac.addAction(UIAlertAction(title: "Sort by date", style: .default, handler: { [self] _ in
            posts = posts.sorted(by: { $0.timeshamp > $1.timeshamp })
            tableView.reloadData()
        }))
        //sort by rating
        ac.addAction(UIAlertAction(title: "Sort by rating", style: .default, handler: {[self] _ in
            posts = posts.sorted(by: { $0.likes_count > $1.likes_count })
            tableView.reloadData()
        }))

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPosts = try? decoder.decode(Posts.self, from: json) {
            posts = jsonPosts.posts
            tableView.reloadData()
        } else {
            print("Fail Parsing!")
        }
    }
    
}

