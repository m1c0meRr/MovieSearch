//
//  Box.swift
//  M22_MVVM_Homework
//
//  Created by Sergey Savinkov on 26.12.2023.
//

import Foundation

final class Observable<T> {

    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
