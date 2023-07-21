//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Erat on 10.07.2023.
//

import Foundation

// string veri tipine yeni özellik ekliyoruz
extension String {
    // ilk harfi büyük yapma
    func capitaLizefirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
