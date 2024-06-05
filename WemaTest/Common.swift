//
//  Common.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import UIKit


struct API {
    static let lock: String = "36b6c4caa08709f7f23c1fe27f297978"
    static let id: String = "appid="
}

struct Link {
    static let currentLink: String = "https://api.openweathermap.org/data/2.5/weather?"
}

struct Cities {
    static let id: String = "&q="
}

struct Units {
    static let id: String = "&units="
    static let celcius: String = "metric"
    static let fahrenheit: String = "imperial"
}

struct Constant {
    static let storyBoardIdentifier: String = "DetailView"
    static let favCity: String = "favCity"
    static let favIcon: String = "heart.fill"
    static let placeholder: String = "Enter a city"
    static let empty: String = ""
    static let descString: String = "Weather Description:"
    static let tempString: String = "Temperature:"
    static let celcius: String = "°C"
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
