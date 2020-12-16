//
//  HCTableViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 07/12/20.
//

import UIKit

class HCTableViewController: UITableViewController, HCCoinDataDelegate {
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HCCoinData.shared.coins.count
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
