//
//  HCCoinData.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 14/12/20.
//

import UIKit
import Foundation

private let currencySymbol: String = "USD"

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
        
        // crypto currency service request
        cryptoService.fetchCryptoCurrency(symbols: listOfSymbols, currency: currencySymbol) { (json: [String:Any]) in
            for coin in self.coins {
                if let coinJSON = json[coin.symbol] as? [String: Double] {
                    if let price = coinJSON["USD"] {
                        coin.price = price
                        HCPreferences.setValue(value: price, key: coin.symbol)
                    }
                }
            }
            self.delegate?.newPrices?()
        }
    }
    
    func doubleToMoneyString(double: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.string(from: NSNumber(floatLiteral: double))
        
        if let formattedPrice = formatter.string(from: NSNumber(floatLiteral: double)) {
            return formattedPrice
        } else{
            return "Error fetching price"
        }
    }
    
    func networthAsString() -> String {
        var networth = 0.0
        for coin in coins {
            networth += coin.amount * coin.price
        }
        return doubleToMoneyString(double: networth)
    }
    
    func html() -> String {
        var html = "<h1>My Crypto Report</h1>"
        html += "<h2>Net Worth: \(networthAsString())</h2>"
        html += "<ul>"
        for coin in coins {
            if coin.amount != 0.0 {
                html += "<li>\(coin.symbol) - I own: \(coin.amount) - Valued at: \(doubleToMoneyString(double: coin.amount * coin.price))</li>"
            }
        }
        html += "</ul>"
        return html
    }
    
}

@objc protocol HCCoinDataDelegate: AnyObject {
    @objc optional func newPrices()
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
        
        self.price = HCPreferences.getDouble(key: symbol)
        self.amount = HCPreferences.getDouble(key: symbol + "amount")
        
        if let historicalData = HCPreferences.getArray(key: symbol + "history") as? [Double] {
            self.historicalData = historicalData
        }
    }
    
    func getName() -> String {
        
        if symbol == "ETH" {
            return "Ethereum"
        } else if symbol == "BTC" {
            return "Bitcoin"
        } else if symbol == "LTC" {
            return "Litecoin"
        } else {
            return "Not found"
        }
    }
    
    func getHistoricalData() {
        
        // crypto historical data service request
        HCCryptoHistoricalDataService().fetchCryptoHistoricalData(symbol: self.symbol, currency: currencySymbol, limit: 30) { (json: [String: Any]) in
            
            if let priceJSON = json["Data"] as? [[String: Any]] {
                self.historicalData = []
                for priceJSON in priceJSON {
                    if let closePrice = priceJSON["close"] {
                        self.historicalData.append(closePrice as! Double)
                    }
                }
            }
            HCCoinData.shared.delegate?.newHistoricalData?()
            HCPreferences.setValue(value: self.historicalData, key: self.symbol + "history")
        }
    }
    
    func priceAsString() -> String {
        if price == 0.0 {
            return "Loading..."
        }
        return HCCoinData.shared.doubleToMoneyString(double: price)
    }
    
    func amountAsString() -> String {
        return HCCoinData.shared.doubleToMoneyString(double: amount * price)
    }
}
