//
//  String.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

extension String {
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
