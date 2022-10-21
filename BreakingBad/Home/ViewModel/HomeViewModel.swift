//
//  HomeViewModel.swift
//  BreakingBad
//
//  Created by Philip Martin on 26/06/2022.
//

import Foundation

protocol HomeViewModelOutput: AnyObject {
    func contentRecieved(model: [Character])
    func requestFailed(error: String)
}

protocol HomeViewModelServiceable {
    func getAllCharacters() async -> Result<[Character], RequestError>
}

class HomeViewModel: HTTPClient, HomeViewModelServiceable {
    
    weak var output: HomeViewModelOutput?
    
    @MainActor func fetchCharacters() {
        Task {
            let result = await getAllCharacters()
            switch result {
            case .success(let model):
                output?.contentRecieved(model: model)
            case .failure(let error):
                output?.requestFailed(error: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Internal Helper
    internal func getAllCharacters() async -> Result<[Character], RequestError> {
        return await sendRequest(endpoint: CharacterEndpoint.getAllCharacters, responseModel: [Character].self)
    }
}

