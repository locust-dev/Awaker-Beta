//
//  ProfileViewModel.swift
//  Awaker
//
//  Created by Ilya Turin on 11.03.2022.
//

import RxSwift

final class ProfileViewModel {
    
    // MARK: - Properties
    
    let isLoading = PublishSubject<Bool>()
    let cellModel = PublishSubject<[String]>()
    
    private let databaseService = DatabaseService()
    
    
    // MARK: - Public methods
    
    func fetchProfileInfo() {
        
        isLoading.onNext(true)
        
        globalQueue(delay: 2) {
            
            self.databaseService.getData(.profile, modelType: ProfileModel.self) { [weak self] result in
                
                switch result {
                    
                case .success(let profileModel):
                    self?.cellModel.onNext(profileModel.cells)
                    
                case .failure(_):
                    break
                }
                
                self?.isLoading.onNext(false)
            }
        }
        
    }
    
}
