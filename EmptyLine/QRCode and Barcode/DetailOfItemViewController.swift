//
//  DetailOfItemViewController.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailOfItemViewController: UIViewController {

    
    private var ditailistTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ditailistTableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
        ditailistTableView.dataSource = self
        ditailistTableView.delegate = self
        ditailistTableView.register(ItemDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.ditailistTableView)
    }
}
extension DetailOfItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemDetailTableViewCell else { return UITableViewCell()}
        return cell
    }
}
