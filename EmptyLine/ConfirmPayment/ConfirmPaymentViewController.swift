//
//  ConfirmPaymentViewController.swift
//  EmptyLine
//
//  Created by Jose Alarcon Chacon on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ConfirmPaymentViewController: UIViewController {
    
    private var confirmView = ConfirmPaymentView()
    private var activityView:UIActivityIndicatorView!
    private var setButton: SetRoundedButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Payment Method"
        view.backgroundColor = .white
        self.view.addSubview(confirmView)
        settingButton()
        confirmView.confirmPaymentTableView.reloadData()
        confirmView.confirmPaymentTableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
        confirmView.confirmPaymentTableView.delegate = self
        confirmView.confirmPaymentTableView.dataSource = self
        confirmView.confirmPaymentTableView.register(ConfirmPaymentTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    private func settingButton() {
        setButton = SetRoundedButton(frame: CGRect(x: 10, y: 10, width: 150, height: 35))
        setButton.setTitleColor(UIColor.black, for: .normal)
        setButton.setTitle("Pay", for: .normal)
        setButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        setButton.center = CGPoint(x: view.center.x, y: view.frame.height - setButton.frame.height - 84)
        setButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        setButton.addTarget(self, action: #selector(confirmPayment), for: .touchUpInside)
        setButton.alpha = 0.5
        view.addSubview(setButton)
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = setButton.center
        view.addSubview(activityView)
    }
    @objc func confirmPayment() {
        activityView.startAnimating()
        print("Pay successfuly")
    }
}

extension ConfirmPaymentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ConfirmPaymentTableViewCell else { return UITableViewCell()}
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
