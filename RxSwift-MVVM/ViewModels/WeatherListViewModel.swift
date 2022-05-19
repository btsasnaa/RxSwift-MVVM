//
//  WeatherListViewModel.swift
//  RxSwift-MVVM
//
//  Created by khabuko on 2022.05.19.
//

import Foundation
import RxSwift

final class WeatherListViewModel {
    let navTitle = "Weathers"
    
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }
    
    func fetchWeatherViewModels() -> Observable<[WeatherViewModel]> {
        dataService.fetchDataLocal().map { $0.map {
            WeatherViewModel(weather: $0)
        }}
    }
    
}
