//
//  HCTableViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 07/12/20.
//

import UIKit

private let rowHeight: CGFloat = 74.0
private let headerHeight: CGFloat = 160.0
private let netWorthHeight: CGFloat = 40.0

class HCCoinTableViewController: UITableViewController, HCCoinDataDelegate {
    
    var amountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HCCoinData.shared.delegate = self
        displayNetWorth()
        tableView.reloadData()
    }
    
    // MARK: - Setup
    
    func setup() {
        title = "Crypto Tracker"
        navigationController?.navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemGroupedBackground
        } else {
            // Fallback on earlier versions
            tableView.backgroundColor = .groupTableViewBackground
        }
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Data
    
    private func loadData() {
        HCCoinData.shared.getPrices()
    }
    
    // MARK: - Delegates
    
    func newPrices() {
        displayNetWorth()
        tableView.reloadData()
    }
    
    func displayNetWorth() {
        amountLabel.text = HCCoinData.shared.networthAsString()
    }
    
    // MARK: - Table view data source
    
    func headerView() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width, height: headerHeight))
        headerView.backgroundColor = .white
        
        let networthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: netWorthHeight))
        networthLabel.backgroundColor = .white
        networthLabel.textAlignment = .center
        networthLabel.font = UIFont(name: "AvenirNext-Regular", size: 16.0)
        networthLabel.text = "Hello, Your Crypto Net Worth"
        headerView.addSubview(networthLabel)
        
        amountLabel.frame = CGRect(x: 0, y: netWorthHeight, width: view.frame.size.width, height: headerHeight - netWorthHeight - 20)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 48.0)
        headerView.addSubview(amountLabel)
        
        displayNetWorth()
        
        return headerView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HCCoinData.shared.coins.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "coinCell")
        
        // Configure the cell...
        let coin = HCCoinData.shared.coins[indexPath.row]
        cell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        cell.detailTextLabel?.font = UIFont(name: "AvenirNext-Regular", size: 14.0)
        
        cell.textLabel?.text = coin.getName()
        if coin.amount != 0.0 {
            cell.detailTextLabel?.text = "\(coin.symbol) - \(coin.priceAsString()) - \(coin.amount)"
        } else {
            cell.detailTextLabel?.text = "\(coin.symbol) - \(coin.priceAsString())"
        }
        cell.imageView?.image = coin.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinVC = HCCoinDetailViewController()
        coinVC.coin = HCCoinData.shared.coins[indexPath.row]
        navigationController?.pushViewController(coinVC, animated: true)
    }
    
}
