//
//  SettingsViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var settingView = SettingsView()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingView)
        tableView.dataSource = self
        tableViewconstriant()
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func tableViewconstriant() {
            self.view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.topAnchor.constraint(equalTo: view.topAnchor , constant: 1).isActive = true
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
}
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell()}
    
        return cell
    }
    
    
}
