//
//  SettingsViewController.swift
//  EmptyLine
//
//  Created by Pursuit on 4/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

//import UIKit
//import PureLayout
//
//class SettingsViewController: UIViewController {
//
//    var settingView = SettingsView()
//    private var profileView = ProfileView()
//    var tesla = ["Mode", "Tesla"]
//
//    
//    lazy var tableView: UITableView = {
//        let table = UITableView()
//        table.estimatedRowHeight = 50
//        table.rowHeight = UITableView.automaticDimension
//        return table
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(settingView)
//        view.addSubview(tableView)
//        tableView.dataSource = self
////        tableView.delegate = self
//        tableViewconstriant()
//        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "Cell")
//        settingView.segmentedControl.addTarget(self, action: #selector(segmentedControlPress(_:)), for: .valueChanged)
//    }
//    func tableViewconstriant() {
//        self.view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: settingView.segmentedControl.bottomAnchor , constant: 1).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//    }
//    
//    @objc func segmentedControlPress(_ sender: UISegmentedControl) {
//        print("Hey")
//        self.tableView.reloadData()
//    }
//}
//
//extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         return tesla.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell()}
//        cell.namelLabel.text = tesla[indexPath.row]
//        return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//}
