//
//  MultitudeArray.swift
//
//
//  Created by Dr. Brandon Wiley on 11/10/23.
//

import Accelerate
import Foundation
import simd

import Multitude

public class MultitudeArray<Internal: MultitudeValue>: Multitude
{
    static public var multitudeValueType: MultitudeValueType
    {
        return Internal.multitudeValueType
    }

    let array: [Internal]

    public init()
    {
        self.array = []
    }

    public required init(array: [Internal])
    {
        self.array = array
    }

    public func length() -> Int
    {
        return self.array.count
    }
    
    public func get(index: Int, type: MultitudeValueType) throws -> MultitudeValueVariant
    {
        guard index >= 0, index < self.array.count else
        {
            throw MultitudeArrayError.badIndex(index)
        }

        let internalType = self.array[index]

        guard let converted = internalType.convert(target: type) else
        {
            throw MultitudeArrayError.badConversion
        }

        switch type
        {
            case .int:
                guard let result = converted as? Int else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .int(result)

            case .int8:
                guard let result = converted as? Int8 else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .int8(result)

            case .int16:
                guard let result = converted as? Int16 else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .int16(result)

            case .int32:
                guard let result = converted as? Int32 else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .int32(result)

            case .int64:
                guard let result = converted as? Int64 else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .int64(result)

            case .uint:
                guard let result = converted as? UInt else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .uint(result)

            case .uint8:
                guard let result = converted as? UInt8 else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .uint8(result)

            case .uint16:
                guard let result = converted as? UInt16 else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .uint16(result)

            case .uint32:
                guard let result = converted as? UInt32 else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .uint32(result)

            case .uint64:
                guard let result = converted as? UInt64 else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .uint64(result)

            case .float:
                guard let result = converted as? Float else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .float(result)

            case .double:
                guard let result = converted as? Double else
                {
                    throw MultitudeArrayError.badConversion
                }

                return .double(result)
        }
    }
    
    public func sum(type: MultitudeValueType) throws -> MultitudeValueVariant
    {
        switch type
        {
            case .int:
                let reduced = try self.array.reduce(Int.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .int) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? Int else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .int(reduced)

            case .int8:
                let reduced = try self.array.reduce(Int8.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .int8) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? Int8 else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .int8(reduced)

            case .int16:
                let reduced = try self.array.reduce(Int16.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .int16) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? Int16 else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .int16(reduced)

            case .int32:
                let reduced = try self.array.reduce(Int32.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .int32) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? Int32 else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .int32(reduced)

            case .int64:
                let reduced = try self.array.reduce(Int64.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .int64) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? Int64 else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .int64(reduced)

            case .uint:
                let reduced = try self.array.reduce(UInt.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .uint) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? UInt else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .uint(reduced)

            case .uint8:
                let reduced = try self.array.reduce(UInt8.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .uint8) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? UInt8 else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .uint8(reduced)

            case .uint16:
                let reduced = try self.array.reduce(UInt16.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .uint16) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? UInt16 else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .uint16(reduced)

            case .uint32:
                let reduced = try self.array.reduce(UInt32.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .uint32) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? UInt32 else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .uint32(reduced)

            case .uint64:
                let reduced = try self.array.reduce(UInt64.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .uint64) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? UInt64 else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .uint64(reduced)

            case .float:
                let reduced = try self.array.reduce(Float.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .float) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? Float else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .float(reduced)

            case .double:
                let reduced = try self.array.reduce(Double.zero)
                {
                    partialResult, newValue in

                    guard let converted = newValue.convert(target: .double) else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    guard let typed = converted as? Double else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    return partialResult + typed
                }

                return .double(reduced)
        }
    }
    
    public func append(value: any MultitudeValue) throws -> Self
    {
        guard let internalType = value.convert(target: Internal.multitudeValueType) as? Internal else
        {
            throw MultitudeArrayError.badConversion
        }

        return Self(array: self.array + [internalType])
    }
    
    public func join(other: Multitude) throws -> Self
    {
        let mapped = try other.map
        {
            value in

            guard let internalType = value.convert(target: Internal.multitudeValueType) as? Internal else
            {
                throw MultitudeArrayError.badConversion
            }

            return internalType
        }

        guard let result = mapped as? MultitudeArray<Internal> else
        {
            throw MultitudeArrayError.badConversion
        }

        return Self(array: self.array + result.array)
    }

    public func replicate(selector: any Multitude) throws -> Self
    {
        let zero: Internal = Internal.zero
        var newArray = [Internal](repeating: zero, count: selector.length())

        for index in 0..<selector.length()
        {
            let indexToReplicateChoice = try selector.get(index: index, type: MultitudeValueType.int)
            switch indexToReplicateChoice
            {
                case .int(let int):
                    let converted = try self.get(index: int, type: .int)
                    guard let value: Internal = converted as? Internal else
                    {
                        throw MultitudeArrayError.badConversion
                    }

                    newArray.append(value)

                default:
                    throw MultitudeArrayError.badConversion
            }
        }

        return Self(array: newArray)
    }
    
    public func replicate(repeats: Int) -> Self
    {
        if repeats == self.length()
        {
            return Self(array: self.array + self.array)
        }
        else if repeats > self.length()
        {
            let whole = repeats / self.length()
            let part = repeats % self.length()

            var newArray = self.array
            for _ in 0..<whole
            {
                newArray = newArray + self.array
            }

            if part > 0
            {
                newArray = newArray + [Internal](self.array[0..<part])
            }

            return Self(array: newArray)
        }
        else // if repeats < self.length()
        {
            let newArray = [Internal](self.array[0..<repeats])
            return Self(array: newArray)
        }
    }

    public func map<Result: MultitudeValue>(_ f: (any MultitudeValue) throws -> Result) throws -> MultitudeArray<Result>
    {
        let newArray = try self.array.map
        {
            value in

            return try f(value)
        }

        return MultitudeArray<Result>(array: newArray)
    }

    public func map<Result: MultitudeValue>(_ f: (any MultitudeValue) throws -> Result) throws -> any Multitude
    {
        let mapped = try self.array.map
        {
            value in

            return try f(value)
        }

        return MultitudeArray<Result>(array: mapped)
    }

    public func array(type: MultitudeValueType) throws -> [any MultitudeValue]
    {
        if type == Internal.multitudeValueType
        {
            return self.array
        }
        else
        {
            return try self.array.map
            {
                value in

                guard let converted = value.convert(target: type) else
                {
                    throw MultitudeArrayError.badConversion
                }

                return converted
            }
        }
    }
}

public enum MultitudeArrayError: Error
{
    case badConversion
    case badIndex(Int)
}
