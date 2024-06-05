# WemaTest
## Overview
Project is a simple weather application that fetches and displays weather data for a given city. It is built using the Model-View-ViewModel (MVVM) architecture pattern and leverages asynchronous programming with async/await to handle network requests. The app also includes unit tests to ensure the reliability of the data fetching and handling processes.

## Structure
The application is divided into several key components:

* Models: Define the data structures.
* ViewModel: Handles data fetching and business logic.
* Views: UI components displaying data.
* Services: Handle network requests and data parsing.
## Models
The models represent the weather data structures:

* WeatherModel: The main model containing weather information.
* CurrentWeather: A model representing the current weather conditions.
* CurrentMain: A model representing the main weather parameters like temperature.
## ViewModel
The WeatherViewModel is responsible for fetching weather data and notifying the view (via a delegate) when data is available or an error occurs.
## Services
The HTTPUtility service handles the network requests using async/await and decodes the received JSON data into model objects.
So the 
## Weather Resource
The WeatherResource struct conforms to the WeatherProtocol and uses the HTTPUtility to fetch weather data asynchronously.
## Unit Tests
The unit tests ensure the reliability of the WeatherViewModel and its data fetching process. The MockWeatherService and MockWeatherDelegate are used to simulate network responses and delegate calls.
## Conclusion
Project  demonstrates a robust architecture for a weather application using MVVM and async/await for network calls. The application is thoroughly unit tested to ensure reliability and correctness.
