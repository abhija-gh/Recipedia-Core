//
//  Cancellables.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 04/12/20.
//

import Combine

typealias DisposeBag = Set<AnyCancellable>
public extension DisposeBag {
    mutating func dispose() {
        forEach { $0.cancel() }
        removeAll()
    }
}
