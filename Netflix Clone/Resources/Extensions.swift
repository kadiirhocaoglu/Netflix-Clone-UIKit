//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 25.09.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
