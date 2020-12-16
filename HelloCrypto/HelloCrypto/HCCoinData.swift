//
//  HCCoinData.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 14/12/20.
//

import UIKit
import Foundation

class HCCoinData {
    
    static let shared = HCCoinData()
    private let cryptoService = HCCryptoService()
    
    weak var delegate: HCCoinDataDelegate?
    
    var coins = [Coin]()
    
    private init() {
        
        let symbols = ["BTC", "ETH", "LTC"]
        
        for symbol in symbols {
            let coin = Coin(symbol: symbol)
            coins.append(coin)
        }
    }
    
    func getPrices() {
        
        var listOfSymbols = ""
        for coin in coins {
            listOfSymbols += coin.symbol
            if coin.symbol != coins.last?.symbol {
                listOfSymbols += ","
            }
        }
        
        cryptoService.fetchCryptoCurrency(symbols: listOfSymbols, currency: "USD") { (json: [String:Any]) in
            
            for coin in self.coins {
                if let coinJSON = json[coin.symbol] as? [String: Double] {
                    if let price = coinJSON["USD"] {
                        coin.price = price
                    }
                }
            }
            self.delegate?.newPrice?()
        }
    }
}

@objc protocol HCCoinDataDelegate: class {
    @objc optional func newPrice()
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
