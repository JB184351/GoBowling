//
//  ViewController.swift
//  bitcoin
//
//  Created by Justin Bengtson on 1/30/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Next two lines gives defaults for user
        
        getDefaultPrices()
        getPrice()
    }
    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpnLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    
    func getDefaultPrices() {
        let usdPrice = UserDefaults.standard.double(forKey: "USD")
        let jpnPrice = UserDefaults.standard.double(forKey: "JPY")
        let eurPrice = UserDefaults.standard.double(forKey: "EUR")
        
        if usdPrice != 0.0 {
            self.usdLabel.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD") + "~"
        }
        
        if jpnPrice != 0.0 {
            self.jpnLabel.text = self.doubleToMoneyString(price: jpnPrice, currencyCode: "JPY") + "~"
        }
        
        if eurPrice != 0.0 {
            self.eurLabel.text = self.doubleToMoneyString(price: eurPrice, currencyCode: "EUR") + "~"
        }
    }
    
    
    func getPrice() {
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Data object
                if let data = data {
                    // Parsing JSON
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Double] {
                        if let jsonDictionary = json {
                            // Doing all the work on the main thread when availiable apple handles doing work on other threads
                            DispatchQueue.main.async {
                                if let usdPrice = jsonDictionary["USD"] {
                                    self.usdLabel.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD")
                                    UserDefaults.standard.set(usdPrice, forKey: "USD")
                                }
                                
                                if let jpnPrice = jsonDictionary["JPY"] {
                                    self.jpnLabel.text = self.doubleToMoneyString(price: jpnPrice, currencyCode: "JPY")
                                    UserDefaults.standard.set(jpnPrice, forKey: "JPY")
                                    UserDefaults.standard.synchronize()
                                }
                                
                                if let eurPrice = jsonDictionary["EUR"] {
                                    self.eurLabel.text = self.doubleToMoneyString(price: eurPrice, currencyCode: "EUR")
                                    UserDefaults.standard.set(eurPrice, forKey: "EUR")
                                    UserDefaults.standard.synchronize()
                                }
                            }
                        }
                    }
                }
                else {
                    print("Something didn't go quite right")
                }
            }.resume()
        }
    }
    
    func doubleToMoneyString(price: Double, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        let priceString = formatter.string(from: NSNumber(value: price))
        
        if priceString == nil {
            return "ERROR"
        }
        else {
          return priceString!
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        getPrice()
    }
    
}

