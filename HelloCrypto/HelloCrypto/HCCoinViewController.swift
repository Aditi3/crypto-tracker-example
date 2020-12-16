//
//  HCCoinViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 16/12/20.
//

import UIKit

class HCCoinViewController: UIViewController {
    
    var coin: Coin?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.view.backgroundColor = .white
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
