//
//  WeatherViewModel.swift
//  RxSwift-MVVM
//
//  Created by khabuko on 2022.05.19.
//

import Foundation

struct WeatherViewModel {
    private let weather: Weather
    
    var text: String {
        return weather.day + " " + weather.desc
    }
    
    var imageName: String {
        return weather.image
    }
    
    init(weather: Weather) {
        self.weather = weather
    }
}
