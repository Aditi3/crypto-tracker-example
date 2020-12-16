//
//  HCCoinViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 16/12/20.
//

import UIKit
import SwiftChart

private let chartHeight: CGFloat = 300.0
private let imageSize: CGFloat = 84.0
private let priceLabelHeight: CGFloat = 34.0
private let padding: CGFloat = 20.0

class HCCoinViewController: UIViewController, HCCoinDataDelegate {
    
    var coin: Coin?
    var chart = Chart()
    var priceLabel = UILabel()
    var youOwnLabel = UILabel()
    var worthLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HCCoinData.shared.delegate = self
        
        setup()
        setupChart()
        setupImageView()
        setupPriceLabel()
        setupOwningLabel()
        setupWorthLabel()
        
        loadData()
    }
    
    // MARK: - Setup
    
    func setup() {
        self.view.backgroundColor = .white
        title = coin?.symbol
        navigationController?.navigationBar.isTranslucent = false
        edgesForExtendedLayout = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
    }
    
    func setupChart() {
        chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartHeight)
        chart.yLabelsFormatter = {HCCoinData.shared.doubleToMoneyString(double: $1)}
        chart.xLabels = [30, 25, 20, 15, 10, 5, 0]
        chart.xLabelsFormatter = { String(Int(round(30 - $1))) + "d"}
        self.view.addSubview(chart)
    }
    
    func setupImageView() {
        let imageView = UIImageView(frame: CGRect(x: self.view.frame.size.width/2 - imageSize/2, y: chartHeight + padding, width: imageSize, height: imageSize))
        imageView.image = coin?.image
        self.view.addSubview(imageView)
    }
    
    func setupPriceLabel() {
        priceLabel = UILabel(frame: CGRect(x: 0, y: chartHeight + imageSize + padding, width: self.view.frame.size.width, height: priceLabelHeight))
        priceLabel.textAlignment = .center
        self.view.addSubview(priceLabel)
    }
    
    func setupOwningLabel() {
        youOwnLabel.frame = CGRect(x: 0, y: priceLabel.frame.origin.y + priceLabel.frame.size.height, width: self.view.frame.size.width, height: priceLabelHeight)
        youOwnLabel.textAlignment = .center
        youOwnLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.view.addSubview(youOwnLabel)
    }
    
    func setupWorthLabel() {
        worthLabel.frame = CGRect(x: 0, y: youOwnLabel.frame.origin.y + youOwnLabel.frame.size.height, width: self.view.frame.size.width, height: priceLabelHeight)
        worthLabel.textAlignment = .center
        worthLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.view.addSubview(worthLabel)
    }
    
    // MARK: - Data
    
    func loadData() {
        coin?.getHistoricalData()
        newPrices()
    }
    
    // MARK: - Delegate
    
    func newHistoricalData() {
        if let coin = coin {
            let series = ChartSeries(coin.historicalData)
            series.area = true
            chart.add(series)
        }
    }
    
    func newPrices() {
        if let coin = coin {
            priceLabel.text = coin.priceAsString()
            youOwnLabel.text = "You own: \(coin.amount) \(coin.symbol)"
            worthLabel.text = coin.amountAsString()
        }
    }
    
    // MARK: - Action
    
    @objc func editTapped() {
        
        if let coin = coin {
            let alert = UIAlertController(title: "How much \(coin.symbol) do you own?", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "0.5"
                textField.keyboardType = .decimalPad
                if self.coin?.amount != 0.0 {
                    textField.text = String(coin.amount)
                }
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                if let text = alert.textFields?[0].text {
                    if let amount = Double(text) {
                        self.coin?.amount = amount
                        self.newPrices()
                    }
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
