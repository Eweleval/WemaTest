//
//  HomeViewController+Extensions.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import Foundation
import UIKit

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.placeholder = "Enter a city"
            return true
        } else {
            textField.placeholder = "Enter a city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchField.text {
            weatherModel.getCityName(cityName: city)
        }
        DispatchQueue.main.async {
            self.weatherModel.receiveData()
        }
    }
}

extension HomeViewController:WeatherDataDelegate {
    func errorhandler(_ data: UserError) {
        DispatchQueue.main.async {
            self.errorField.text = data.localizedDescription.capitalized
            self.errorField.isHidden = false
            
        }
        
        DispatchQueue.main.asyncAfter(deadline:.now() + 3.0) {
            self.errorField.isHidden = true
        }
    }
    
    func receiveData(_ data: WeatherModel) {
        let storyboard = self.storyboard?.instantiateViewController(identifier: "DetailView") as! DetailViewController
        storyboard.weatherData = data
        self.navigationController?.pushViewController(storyboard, animated: true)
        searchField.text = ""
    }
}
