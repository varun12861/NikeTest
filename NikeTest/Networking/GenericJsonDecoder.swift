//
//  GenericJsonDecoder.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation

import Foundation

protocol GenericJsonDecoder {
    associatedtype OUT:Decodable
    func decode(input:Data) -> OUT?
}

extension GenericJsonDecoder {
    func decode(input:Data) -> OUT? {
        do {
           return  try JSONDecoder().decode(OUT.self, from: input)
        }catch {
            return nil
        }
    }
}
