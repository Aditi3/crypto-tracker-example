//
//  HCCoinViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 16/12/20.
//

import UIKit
import SwiftChart

private let chartHeight: CGFloat = 300.0

class HCCoinViewController: UIViewController {
    
    var coin: Coin?
    var chart = Chart()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupChart()
        loadData()
    }
    
    func setup() {
        self.view.backgroundColor = .white
    }
    
    func setupChart() {
       
        chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartHeight)
        let series = ChartSeries([0, 5, 6, 8, 9, 19])
        chart.add(series)
        self.view.addSubview(chart)
    }
    
    func loadData() {
        coin?.getHistoricalData()
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
