//
//  Multitude.swift
//
//
//  Created by Dr. Brandon Wiley on 11/10/23.
//

import Foundation

public protocol Multitude
{
    static var multitudeValueType: MultitudeValueType { get }

    func length() -> Int
    func get(index: Int, type: MultitudeValueType) throws -> MultitudeValueVariant
    func sum(type: MultitudeValueType) throws -> MultitudeValueVariant
    func append(value: any MultitudeValue) throws -> Self
    func join(other: any Multitude) throws -> Self
    func replicate(selector: any Multitude) throws -> Self
    func replicate(repeats: Int) throws -> Self
    func map<Result: MultitudeValue>(_ f: (any MultitudeValue) throws -> Result) throws -> any Multitude
    func array(type: MultitudeValueType) throws -> [any MultitudeValue]
}
