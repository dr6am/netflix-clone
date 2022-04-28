//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Alejandro on 4/26/22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
