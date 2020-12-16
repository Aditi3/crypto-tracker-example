//
//  HCTableViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 07/12/20.
//

import UIKit

private let headerHeight: CGFloat = 100.0
private let netWorthHeight: CGFloat = 40.0


class HCTableViewController: UITableViewController, HCCoinDataDelegate {
    
    var amountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HCCoinData.shared.delegate = self
        tableView.reloadData()
    }
    
    // MARK: - Data
    
    private func loadData() {
        HCCoinData.shared.getPrices()
    }
    
    // MARK: - Delegates
    
    func newPrice() {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func headerView() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: headerHeight))
        headerView.backgroundColor = .green
        
        let networthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: netWorthHeight))
        networthLabel.backgroundColor = .white
        networthLabel.textAlignment = .center
        networthLabel.text = "My Crypto Net Worth"
        headerView.addSubview(networthLabel)
        
        amountLabel.frame = CGRect(x: 0, y: netWorthHeight, width: view.frame.size.width, height: headerHeight - netWorthHeight)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
        headerView.addSubview(amountLabel)
                
        return headerView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
        
        let cell = UITableViewCell()
        
        // Configure the cell...
        let coin = HCCoinData.shared.coins[indexPath.row]
        cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString())"
        cell.imageView?.image = coin.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinVC = HCCoinViewController()
        coinVC.coin = HCCoinData.shared.coins[indexPath.row]
        navigationController?.pushViewController(coinVC, animated: true)
        
    }
    
}
