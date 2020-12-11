//
//  animeViewModel.swift
//  AnimalAPP
//
//  Created by hui liu on 12/8/20.
//

import Foundation

class AnimeViewModel {
    var results = Bindable<[Result]>()
    var isSearching = Bindable<Bool>()
    var timer: Timer?
    
    
    func performSearch(_ searchText: String) {
        timer?.invalidate()
        isSearching.value = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            Service.shared.fetchAnimal(searchText: searchText) { [weak self] (res, err) in
                self?.results.value = res?.results ?? []
                self?.isSearching.value = false
            }
        })
    }
    
    func fetchFirstTimeData() {
        Service.shared.fetchFirstTimeData() { [weak self] (res, err) in
            self?.results.value = res?.results ?? []
            self?.isSearching.value = false
        }
    }
}
