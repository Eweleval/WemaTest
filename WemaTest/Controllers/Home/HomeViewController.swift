//
//  HomeViewController.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var errorField: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let userDefaults: UserDefaults = .standard
    let weatherModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        setup()
    }
    
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        
        weatherModel.delegate = self
        searchField.delegate = self
        
        if let favCity = userDefaults.string(forKey: Constant.favCity), !favCity.isEmpty{
            searchField.text = favCity
        }
    }
    
    @IBAction func check(_ sender: Any) {
        if self.searchField.text != Constant.empty {
            self.loader.startAnimating()
            self.checkButton.isEnabled = false
            self.searchField.isEnabled = false
        }
        
        //MARK:- This is to simulate a slow network loading
        DispatchQueue.main.asyncAfter(deadline:.now() + 1.0) { [self] in
            if self.searchField.text != Constant.empty {
                if let city = searchField.text {
                    weatherModel.getCityName(cityName: city.trimmingCharacters(in: .whitespacesAndNewlines))
                }
                DispatchQueue.main.async {
                    self.weatherModel.receiveData()
                }
            }
        }
    }
}
