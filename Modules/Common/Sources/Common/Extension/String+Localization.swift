//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/3/20.
//

import Foundation

extension String {
  func localized() -> String {
    return Bundle.module.localizedString(forKey: self, value: nil, table: nil)
  }
}
