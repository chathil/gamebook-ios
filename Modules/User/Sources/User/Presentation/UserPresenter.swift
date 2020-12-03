//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/3/20.
//

import SwiftUI
import Combine
import Foundation

public class UserPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Published public var fName: String = ""
    @Published public var lName: String = ""
    @Published public var email: String = ""
    @Published public var phoneNumber: String = ""
    @Published public var fNameMessage: String = ""
    @Published public var lNameMessage: String = ""
    @Published public var emailMessage: String = ""
    @Published public var isFormValid: Bool = false
    
    private var isFnameValidPublisher: AnyPublisher<Bool, Never> {
        $fName
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    private var isLnameValidPublisher: AnyPublisher<Bool, Never> {
        $lName
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email.debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { self.isValidEmail(from: $0) }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isFnameValidPublisher, isLnameValidPublisher, isEmailValidPublisher)
            .map { fNameIsValid, lNameIsValid, emailIsValid in
                return fNameIsValid && lNameIsValid && emailIsValid
            }
            .eraseToAnyPublisher()
    }
    
    public init() {
        isFnameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Firstname must at least have 3 characters"
            }
            .assign(to: \.fNameMessage, on: self)
            .store(in: &cancellables)
        isLnameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Lastname must at least have 3 characters"
            }
            .assign(to: \.fNameMessage, on: self)
            .store(in: &cancellables)
        isEmailValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Ain't never seen an email like that."
            }.assign(to: \.emailMessage, on: self)
            .store(in: &cancellables)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
        
    }
    
    private func isValidEmail(from email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
