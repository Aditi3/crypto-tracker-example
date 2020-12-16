//
//  HCCoinViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 16/12/20.
//

import UIKit
import SwiftChart

private let chartHeight: CGFloat = 300.0

class HCCoinViewController: UIViewController, HCCoinDataDelegate {
    
    var coin: Coin?
    var chart = Chart()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HCCoinData.shared.delegate = self
        
        setup()
        setupChart()
        loadData()
    }
    
    func setup() {
        self.view.backgroundColor = .white
        edgesForExtendedLayout = []
    }
    
    func setupChart() {
        chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartHeight)
        self.view.addSubview(chart)
    }
    
    func loadData() {
        coin?.getHistoricalData()
    }
    
    func newHistoricalData() {
        if let coin = coin {
            let series = ChartSeries(coin.historicalData)
            series.area = true
            chart.add(series)
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
