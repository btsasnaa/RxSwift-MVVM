//
//  ViewController.swift
//  RxSwift-MVVM
//
//  Created by khabuko on 2022.05.19.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    // MARK: - Constants
    let disposeBag = DisposeBag()
    
    // MARK: - Variables
    private var viewModel: WeatherListViewModel!

    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.navTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.tableFooterView = UIView()
        viewModel.fetchWeatherViewModels().observe(on: MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: MyCell.self)) { index, model, cell in
            cell.myLabel?.text = model.text
            cell.myImageView.image = UIImage(systemName: model.imageName)
        }.disposed(by: disposeBag)
    }

    static func instantiate(viewModel: WeatherListViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.viewModel = viewModel
        return viewController
    }
}

