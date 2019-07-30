//
//  ViewController.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController {
    @IBOutlet weak var carListTblView: UITableView!
    var carListVM = CarListViewModel()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.color = UIColor.darkGray
        self.activityIndicator.startAnimating()
        carListVM.loadCarList()
        title = "Car List"
        
        let barButton = UIBarButtonItem(image: UIImage(named: "filter"),
                                        landscapeImagePhone: UIImage(named: "filter"),
                                        style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = barButton
        
        
        // This closure is called when there is any error occurs in API call
        carListVM.showError = { [weak self] error in
            self?.activityIndicator.stopAnimating()
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(alertAction)
            self?.present(alert, animated: true, completion: nil)
        }
        
        // This closure is called when the car list updated in 
        carListVM.dataLoaded = { [weak self] success in
            self?.activityIndicator.stopAnimating()
            if success {
                self?.carListTblView.reloadData()
            }
        }
    }
    
    @objc func filterButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "CarFilterViewController") as? CarFilterViewController else { return }
        viewController.filterParameter = carListVM.filterParameter
        viewController.delegate = self
        let navigation = UINavigationController(rootViewController: viewController)
        self.present(navigation, animated: true, completion: nil)
    }
}

extension CarListViewController: CartFilterProtocol {
    func didApplyFilter(with filterParameter: FilterParameter) {
        activityIndicator.startAnimating()
        carListVM.loadCarList(with: filterParameter)
        carListTblView.reloadData()             //
    }
}

extension CarListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carListVM.shouldShowMoreData() ? carListVM.numberOfCars() + 1 : carListVM.numberOfCars()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == carListVM.numberOfCars() {
            guard let loadingCell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell") as? LoadingCell else {
                return UITableViewCell(frame: .zero)
            }
            loadingCell.activityIndicator.startAnimating()
            return loadingCell
        } else {
            guard let carDetailCell = tableView.dequeueReusableCell(withIdentifier: "carDetail") as? CarDetailTableViewCell else {
                return UITableViewCell(frame: .zero)
            }
            guard let detail = carListVM.carAtIndex(index: indexPath.row) else { return UITableViewCell(frame: .zero) }
            carDetailCell.updateWithCarDetail(carDetail: detail)
            return carDetailCell
        }
    }
}
