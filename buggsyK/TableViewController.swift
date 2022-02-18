//
//  TableViewController.swift
//  buggsyK
//
//  Created by Felipe Montoya on 2/10/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var users: [User]! {
        didSet {
            var text: String = ""
            for user in users {
                for _ in user.username {
                    for _ in users {
                        text = !users.isEmpty ? "\(users.count) active twitter users" : ":( No users"
                        self.tableView.reloadData()
                    }
                }
            }
            self.footerLabel.text = text
            self.tableView.reloadData()
        }
    }
    
    private var footerLabel: UILabel! = {
        let label = UILabel()
        label.text = "Buggsy by Kodemia"
        label.font = .boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private var setRefreshControl: () -> UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action:
                            #selector(handleRefreshControl),
                            for: .valueChanged)
       
        return control
    }
    
        
    @objc private func handleRefreshControl() {
        requestUsersData()
    }
    
    private func composeUI() {
        tableView.tableFooterView = footerLabel
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NormalCellType")
        
    }
    
 
    private func requestUsersData() {
        APIClient.downloadUsers { result in
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                switch result {
                case .success(let users):
                    self.users += users
                case .failure(_):
                    //TODO: Handle error
                    break
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeUI()
        tableView.refreshControl = setRefreshControl()
        requestUsersData()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.title = "Users"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return { return Optional(0) }() ?? users.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "@\(users[indexPath.row].username)"
        cell.imageView?.image = UIImage(imageLiteralResourceName: "twitter-bird")
        cell.isUserInteractionEnabled = false
        return cell
    }

}

