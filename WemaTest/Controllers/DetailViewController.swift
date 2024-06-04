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
    let image = UIImage(systemName: "heart.fill")
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
        view.backgroundColor = .systemBlue
        self.navigationController?.navigationBar.tintColor = .black
        
        descriptionLabel.text = "Weather Description: \( weatherData?.weather[0].weatherDescription.capitalized ?? "Its Bad")"
        temperatureLabel.text = "Temperature: \(Int( weatherData?.main.temp ?? 0))°C"
        
        barButton.tintColor =  userDefaults.string(forKey: "favCity") == weatherData?.name ?
            .red : .white
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func barButtonTapped() {
        userDefaults.set(weatherData?.name, forKey: "favCity")
        barButton.tintColor = .red
    }
}
