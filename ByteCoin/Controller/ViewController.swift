//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var biticoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

//MARK: -- UIPickerView DataSource & Delegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    //inicia o array
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //chama os items para as row e conta
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    //converte os dados para uma string
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //troca de cor os items
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: coinManager.currencyArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    //envia o dado escolhido para o coinManager fazer a converção
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        
        
    }
}

//MARK: -- CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            //atualiza os dados na label
            self.biticoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
