//
//  HCTableViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 07/12/20.
//

import UIKit
import LocalAuthentication

private let rowHeight: CGFloat = 74.0
private let headerHeight: CGFloat = 160.0
private let netWorthHeight: CGFloat = 40.0

class HCCryptoTableViewController: UITableViewController, HCCoinDataDelegate {
    
    var amountLabel = UILabel()
    
    // MARK: - View Controller Life Cycle
    
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
        tableView.backgroundColor = Color.background
        tableView.tableFooterView = UIView()
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            updateSecureButton()
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Report", style: .plain, target: self, action: #selector(reportTapped))
    }
    
    
    @objc func reportTapped() {
        let formatter = UIMarkupTextPrintFormatter(markupText: HCCoinData.shared.html())
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(formatter, startingAtPageAt: 0)
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage()
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        UIGraphicsEndPDFContext()
        let shareVC = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        present(shareVC, animated: true, completion: nil)
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
    
    // MARK: - Auth Actions
    
    func updateSecureButton() {
        if HCPreferences.isAppSecure() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Unsecure App", style: .plain, target: self, action: #selector(secureTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Secure App", style: .plain, target: self, action: #selector(secureTapped))
        }
    }
    
    @objc func secureTapped() {
        if HCPreferences.isAppSecure() {
            HCPreferences.updateAppSecureKey(secure: false)
        } else {
            HCPreferences.updateAppSecureKey(secure: true)
        }
        updateSecureButton()
    }
    
    // MARK: - Amount Handling
    
    func displayNetWorth() {
        amountLabel.text = HCCoinData.shared.networthAsString()
    }
    
    // MARK: - Table view data source
    
    func headerView() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width, height: headerHeight))
        headerView.backgroundColor = .systemBackground
        
        let networthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: netWorthHeight))
        networthLabel.textAlignment = .center
        networthLabel.font = UIFont(name: "AvenirNext-Regular", size: 16.0)
        networthLabel.text = "Hello, Your Crypto Net Worth"
        networthLabel.textColor = .label
        headerView.addSubview(networthLabel)
        
        amountLabel.frame = CGRect(x: 0, y: netWorthHeight, width: view.frame.size.width, height: headerHeight - netWorthHeight - 20)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 48.0)
        amountLabel.textColor = .label
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
