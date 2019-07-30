//
//  CarListViewModel.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import AVFoundation

class CarListViewModel: NSObject {
    
    var carList:[CarDetail]? = []
    fileprivate (set) var filterParameter: FilterParameter!
    var paginationModel = PaginationModel()
    var dataLoaded:((_ sucess: Bool) -> ())?            // Closure which gets called when the car list data is loaded.
    var showError:((_ error: Error) -> ())?             // Closure which gets called when there is any error occures in API
    
    func loadCarList(with inFilterParameter: FilterParameter? = nil) {
        filterParameter = inFilterParameter ?? FilterParameter()
    
        carList?.removeAll()
        paginationModel.resetValue()
        paginationModel.pageSize = filterParameter.limit
        filterParameter.offset = paginationModel.currentPage
        
        loadCarList()
    }
    
    func numberOfCars() -> Int {
        return carList?.count ?? 0
    }
    
    func carAtIndex(index: Int) -> CarDetail? {
        if (index + 1) == carList?.count {
            loadNextPage()
        }
        guard index < numberOfCars(), let carDetail = carList?[index] else {
            return nil
        }
        return carDetail
    }
    
    func loadNextPage() {
        if paginationModel.shouldFetchData() {
            paginationModel.currentPage += 1
            loadCarList()
        }
    }
    
    func shouldShowMoreData() -> Bool {
        return paginationModel.shouldFetchData()
    }
    
    private func loadCarList() {
        paginationModel.dataFetching = true
        filterParameter.offset = paginationModel.currentPage
        DataFetcher().loadCarListData(with: filterParameter) { [weak self] (inCartList, error) in
            self?.paginationModel.dataFetching = false
            
            if let _error = error {
                self?.showError?(_error)
            } else {
                guard let result = inCartList?.results else {return}
                self?.carList?.append(contentsOf: result)
                self?.paginationModel.totalNumber = inCartList?.sums?.totalResults ?? 0
                self?.dataLoaded?(true)
            }
        }
    }
}
