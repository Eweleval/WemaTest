//
//  NewTest.swift
//  WemaTestTests
//
//  Created by Wellz Val on 6/4/24.
//

import XCTest
@testable import WemaTest

class MockWeatherDelegate: WeatherDataDelegate {
    var receivedData: WeatherModel?
    var receivedError: UserError?
    
    var expectation: XCTestExpectation?
    
    func receiveData(_ data: WemaTest.WeatherModel) {
        receivedData = data
        expectation?.fulfill()
    }
    
    func errorhandler(_ data: WemaTest.UserError) {
        receivedError = data
        expectation?.fulfill()
    }
}

class MockWeatherService:  WeatherProtocol {
    func getWeatherData() async throws -> WemaTest.WeatherModel {
        let weather = WeatherModel(weather:[ CurrentWeather(id: 2, main: "", weatherDescription: "Partly Cloud", icon: "")], main: CurrentMain(temp: 16.0, feelsLike: 20.0, tempMin: 14.0, tempMax: 16.0), name: "London")
        return weather
    }
}

class HomeViewModelTests: XCTestCase {
    
    var viewModel: WeatherViewModel?
    var userDefaults: UserDefaults?
    var mockDelegate: MockWeatherDelegate?
    
    override func setUp() {
        super.setUp()
        viewModel = WeatherViewModel()
        mockDelegate = MockWeatherDelegate()
        viewModel?.delegate = mockDelegate
        viewModel?.weatherResource = MockWeatherService()
        userDefaults = .standard
    }
    
    override func tearDown() {
        viewModel = nil
        userDefaults = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testFetchWeather()  {
        let expectation = self.expectation(description: "Get Weather")
        mockDelegate?.expectation = expectation
        
        viewModel?.receiveData()
        userDefaults?.set("London", forKey:  Constant.favCity)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(mockDelegate?.receivedData)
        XCTAssertEqual (mockDelegate?.receivedData?.name, "London")
        XCTAssertEqual(mockDelegate?.receivedData?.main.temp, 16.0)
        XCTAssertEqual(mockDelegate?.receivedData?.weather[0].weatherDescription, "Partly Cloud")
    }
    
    func testGetFavoriteCity() {
        if let favCity = userDefaults?.string(forKey: "favCity"), !favCity.isEmpty{
            XCTAssertEqual(favCity, "London")
        }
    }
}
