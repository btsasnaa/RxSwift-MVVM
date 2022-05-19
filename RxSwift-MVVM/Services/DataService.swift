//
//  DataService.swift
//  RxSwift-MVVM
//
//  Created by khabuko on 2022.05.19.
//

import Foundation
import RxSwift

protocol DataServiceProtocol {
    func fetchDataLocal() -> Observable<[Weather]>
    func fetchDataAPI() -> Observable<[Weather]>
}

class DataService: DataServiceProtocol {
    
    // get json local data
    func fetchDataLocal() -> Observable<[Weather]> {
        return Observable.create{ observer -> Disposable in
            
            guard let path = Bundle.main.path(forResource: "my_json", ofType: "json") else {
                observer.onError(NSError(domain: "", code: -1,userInfo: nil))
                return Disposables.create { }
            }
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let weathers = try JSONDecoder().decode([Weather].self, from: data)
                observer.onNext(weathers)
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create { }
        }
    }

    // get json api data
    func fetchDataAPI() -> Observable<[Weather]> {
        return Observable.create{ observer -> Disposable in
            
            let task = URLSession.shared.dataTask(with: URL(string: "my-url")!){
                data, _, _ in
            
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1,userInfo: nil))
                    return
                }
                
                do {
                    let weathers = try JSONDecoder().decode([Weather].self, from: data)
                    observer.onNext(weathers)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
