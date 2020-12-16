//
//  HCCryptoHistoricalDataService.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 16/12/20.
//

import Foundation
import Alamofire

class HCCryptoHistoricalDataService {
    
    private let cryptoBaseUrl = "https://min-api.cryptocompare.com/data/v2/histoday?"
    
    func fetchCryptoHistoricalData(symbol: String, currency: String, limit: String, completion: @escaping ([String:Any]) -> Void) {
        
        let historicalDataUrl: String = cryptoBaseUrl + "fsym=\(symbol)" + "&tsym=\(currency)" + "&limit=\(limit)"
 
        AF.request(historicalDataUrl, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    print(json)
                    DispatchQueue.main.async {
                        completion(json as! [String : Any])
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
