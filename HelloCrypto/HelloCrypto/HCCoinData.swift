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
    @objc optional func newHistoricalData()
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
    
    func getHistoricalData() {
        
        HCCryptoHistoricalDataService().fetchCryptoHistoricalData(symbol: self.symbol, currency: "USD", limit: 30) { (json: [String: Any]) in
            
            if let priceJSON = json["Data"] as? [[String: Any]] {
                self.historicalData = []
                for priceJSON in priceJSON {
                    if let closePrice = priceJSON["close"] {
                        self.historicalData.append(closePrice as! Double)
                    }
                }
            }
        }
    }
    
    func priceAsString() -> String {
        
        if price == 0.0 {
            return "Loading..."
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.string(from: NSNumber(floatLiteral: price))
        
        if let formattedPrice = formatter.string(from: NSNumber(floatLiteral: price)) {
            return formattedPrice
        } else{
            return "Error fetching price"
        }
    }
}
