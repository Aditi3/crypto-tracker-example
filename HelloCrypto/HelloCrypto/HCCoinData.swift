//
//  HCCoinData.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 14/12/20.
//

import UIKit

class HCCoinData {
    
    static let shared = HCCoinData()
    var coins = [Coin]()
    
    private init() {
        
        let symbols = ["BTC", "ETH", "LTC"]
        
        for symbol in symbols {
            let coin = Coin(symbol: symbol)
            coins.append(coin)
        }
    }
}

class Coin {
    var symbol = ""
    var image = UIImage()
    var price = 0.0
    var amount = 0.0
    var historicalData = [Double]()
    
    init(symbol: String) {
       
        self.symbol = symbol
        
        if let image = UIImage(named: symbol.lowercased()) {
           self.image = image
        }
    }
}
