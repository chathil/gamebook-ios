//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/1/20.
//

import SwiftUI
import Combine
 
public class GetPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    private let _request: Request
    
    @Published public var response: Response?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: Interactor, request: Request, response: Response? = nil) {
        _useCase = useCase
        _request = request
        self.response = response
    }
    
    public func get() {
        isLoading = true
        _useCase.execute(request: _request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { response in
                self.response = response
            })
            .store(in: &cancellables)
    }
}
