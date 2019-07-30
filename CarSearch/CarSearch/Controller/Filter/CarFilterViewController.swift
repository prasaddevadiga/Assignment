//
//  CarFilterViewController.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

protocol CartFilterProtocol {
    func didApplyFilter(with filterParameter: FilterParameter)
}

class CarFilterViewController: UIViewController {

    @IBOutlet weak var countrySelection: UISegmentedControl!
    @IBOutlet weak var sortBy: UISegmentedControl!
    @IBOutlet weak var sortType: UISegmentedControl!
    
    var delegate: CartFilterProtocol?
    var filterParameter: FilterParameter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(doneTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        updateUI()
    }
    
    // This method is used to update the selected filter types
    private func updateUI() {
        countrySelection.selectedSegmentIndex = getSelectedIndex(segmentedControl: countrySelection, title: filterParameter?.country?.rawValue ?? "")
        sortBy.selectedSegmentIndex = getSelectedIndex(segmentedControl: sortBy, title: filterParameter?.sorting?.rawValue ?? "")
        sortType.selectedSegmentIndex = getSelectedIndex(segmentedControl: sortType, title: filterParameter?.sortOrder?.rawValue ?? "")
    }
    
    //Gives the segment which matcher the selected option
    func getSelectedIndex(segmentedControl: UISegmentedControl, title: String) -> Int {
        for i in 0..<segmentedControl.numberOfSegments {
            if segmentedControl.titleForSegment(at: i) == title {
                return i
            }
        }
        return 0
    }
    
    @IBAction func countrySelectionValueChanged(_ sender: UISegmentedControl) {
        switch sender.tag {
        case 111:
            filterParameter?.country = Country.country(at: sender.selectedSegmentIndex)
            break
        case 112:
            filterParameter?.sorting = SortType.sortType(at: sender.selectedSegmentIndex)
            break
        case 113:
            filterParameter?.sortOrder = SortOrder.sortOrder(at: sender.selectedSegmentIndex)
            break
        default: break
        }
    }
    
    @objc func doneTapped() {
        guard let _filterParameter = filterParameter else { return }
        
        delegate?.didApplyFilter(with: _filterParameter)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
