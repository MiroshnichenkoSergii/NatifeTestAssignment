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
    
    var toggleAllCells: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Natife Posts List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(filter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Expand All", style: .plain, target: self, action: #selector(expandAll))
        
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
        
        cell.dynamicViewButton.tag = indexPath.row
        
        cell.titleLabel.attributedText = attribute.makeAttributedTitle(title: post.title)
        cell.subtitleLabel.attributedText = attribute.makeAttributedSubtitle(subtitle: post.preview_text)
        
        cell.likesLabel.text = "❤️‍🔥 \(post.likes_count)"
        cell.lastDateLabel.text = "\(dateSettings(post).month ?? 0) month, \(dateSettings(post).day ?? 0) days ago"
        
        if toggleAllCells {
            cell.dynamicViewButton.setTitle("Collapse", for: .normal)
            cell.subtitleLabel.numberOfLines = 0
            return cell
        }
        
        cell.dynamicViewButton.isEnabled = true
        cell.dynamicViewButton.setTitle(cell.buttonTitle, for: .normal) 
        cell.subtitleLabel.numberOfLines = cell.numberOfLines
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.detailItem = posts[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tap(_ sender: UIButton) {
        toggleAllCells = false
        let index = IndexPath(row: sender.tag, section: 0)

        if let cell = tableView.cellForRow(at: index) as? Cell {
            cell.isCellExpanded.toggle()

            if #available(iOS 15.0, *) {
                tableView.reconfigureRows(at: [index])
            } else {
                // for iOS 14 can't test yet
                tableView.reloadRows(at: [index], with: .automatic)
            }
        }
    }
    
    @objc func expandAll() {
        toggleAllCells.toggle()
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
    
    func dateSettings(_ post: Post) -> DateComponents{
        let nowDate: Date
        if #available(iOS 15, *) {
            nowDate = Date.now
        } else {
            nowDate = Date(timeIntervalSinceNow: 0)
        }
        let postingDate = Date(timeIntervalSince1970: TimeInterval(post.timeshamp))
        let diff = Calendar.current.dateComponents([.month, .day], from: postingDate, to: nowDate)
        return diff
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


