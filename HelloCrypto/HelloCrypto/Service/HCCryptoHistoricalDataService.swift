//
//  HCCryptoHistoricalDataService.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 16/12/20.
//

import Foundation
import Alamofire

class HCCryptoHistoricalDataService {
    
    private let cryptoBaseUrl = "https://min-api.cryptocompare.com/data/histoday?"
    
    func fetchCryptoHistoricalData(symbol: String, currency: String, limit: NSNumber, completion: @escaping ([String: Any]) -> Void) {
        
        let historicalDataUrl: String = cryptoBaseUrl + "fsym=\(symbol)" + "&tsym=\(currency)" + "&limit=\(limit)"
        
        AF.request(historicalDataUrl, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    print("Fetched Crypto Historical Data Json: \(json)")
                    DispatchQueue.main.async {
                        completion(json as! [String: Any])
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
