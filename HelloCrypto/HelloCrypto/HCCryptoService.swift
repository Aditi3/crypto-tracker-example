//
//  HCCryptoService.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 16/12/20.
//

import UIKit


final class HCCryptoService {
    
    private let baseUrl = URL(string: "https://min-api.cryptocompare.com/data/pricemulti")!
    
    func fetch(symbols: String, completion: @escaping (HCCoinData?) -> Void) {
        
    }
    
}
