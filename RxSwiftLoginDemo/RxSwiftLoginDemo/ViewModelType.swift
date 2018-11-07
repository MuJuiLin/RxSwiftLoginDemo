//
//  ViewModelType.swift
//
//  Created by joseewu
//

import Foundation

protocol ViewModelBinding {
    associatedtype Inputs
    associatedtype Outputs
    var inputs: Inputs { get }
    var outputs: Outputs { get }
}

protocol ViewModelDependency {
    associatedtype Dependency
    init(withDependency dependency:Dependency)
}
