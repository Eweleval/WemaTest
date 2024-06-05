//
//  DetailViewController.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var weatherData: WeatherModel?
    let userDefaults: UserDefaults = .standard
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    let image = UIImage(systemName: Constant.favIcon)
    lazy var barButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(barButtonTapped))
        return barButton
    }()
    
    init(weatherData: WeatherModel?) {
        self.weatherData = weatherData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.5855334997, green: 0.7699266076, blue: 0.8184378147, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .black
        
        descriptionLabel.text = "\(Constant.descString) \( weatherData?.weather[0].weatherDescription.capitalized ?? Constant.empty)"
        temperatureLabel.text = "\(Constant.tempString) \(Int( weatherData?.main.temp ?? 0))\(Constant.celcius)"
        
        barButton.tintColor =  userDefaults.string(forKey:  Constant.favCity) == weatherData?.name ?
            .red : .white
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func barButtonTapped() {
        userDefaults.set(weatherData?.name, forKey:  Constant.favCity)
        barButton.tintColor = .red
    }
}
