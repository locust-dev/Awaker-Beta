//
//  ProfileViewModel.swift
//  Awaker
//
//  Created by Ilya Turin on 11.03.2022.
//

import RxSwift
import RxCocoa

final class ProfileViewModel {
    
    // MARK: - Properties
    
    private let isLoading = BehaviorSubject<Bool>(value: false)
    private let cellModel = PublishSubject<[String]>()
    private let databaseService = DatabaseService()
    
    
    // MARK: - Public methods
    
    func fetchProfileInfo() {
        
        isLoading.onNext(true)
        
        databaseService.getData(.profile, modelType: ProfileModel.self) { [weak self] result in
            
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


// MARK: - ViewModelType
extension ProfileViewModel: ViewModelType {
    
    struct Input {
        let cellIndex: Driver<IndexPath>
    }
    
    struct Output {
        let cellModel: Driver<[String]>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
 
        let cellModel = cellModel.asDriver(onErrorJustReturn: [])
        let isLoading = isLoading.asDriver(onErrorJustReturn: false)
        
        return Output(cellModel: cellModel, isLoading: isLoading)
    }
}
