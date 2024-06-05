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
}

extension HomeViewController: WeatherDataDelegate {
    func errorhandler(_ data: UserError) {
        DispatchQueue.main.async {
            self.errorField.text = data.localizedDescription.capitalized
            self.errorField.isHidden = false
            
        }
        
        DispatchQueue.main.asyncAfter(deadline:.now() + 3.0) {
            self.loader.stopAnimating()
            self.checkButton.isEnabled = true
            self.errorField.isHidden = true
            self.searchField.isEnabled = true
        }
    }
    
    func receiveData(_ data: WeatherModel) {
        self.loader.stopAnimating()
        let storyboard = self.storyboard?.instantiateViewController(identifier: Constant.storyBoardIdentifier) as! DetailViewController
        storyboard.weatherData = data
        self.navigationController?.pushViewController(storyboard, animated: true)
        searchField.text = Constant.empty
        self.checkButton.isEnabled = true
        self.searchField.isEnabled = true
    }
}
