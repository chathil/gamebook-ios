//
//  AboutPresenter.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class AboutPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Published var fName: String = ""
    @Published var lName: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var fNameMessage: String = ""
    @Published var lNameMessage: String = ""
    @Published var emailMessage: String = ""
    @Published var isFormValid: Bool = false
    
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
    
    init() {
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
