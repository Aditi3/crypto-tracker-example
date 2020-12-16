//
//  HCCryptoService.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 16/12/20.
//

import Foundation
import Alamofire

final class HCCryptoService {
    
    private let baseUrl = "https://min-api.cryptocompare.com/data/pricemulti?"
    
    func fetchCryptoCurrency(symbols: String, currency: String, completion: @escaping ([String:Any]) -> Void) {
        
        let cryptoCurrencyUrl: String = baseUrl + "fsyms=\(symbols)" + "&tsyms=\(currency)"
        
        AF.request(cryptoCurrencyUrl, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    print("Fetched Crypto Currency Json: \(json)")
                    DispatchQueue.main.async {
                        completion(json as! [String : Any])
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
