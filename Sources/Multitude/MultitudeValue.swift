//
//  MultitudeValue.swift
//
//
//  Created by Dr. Brandon Wiley on 11/10/23.
//

import Foundation
import simd

import Datable

public protocol MultitudeValue: MaybeIntable, Floatable, AdditiveArithmetic, SIMDScalar, Codable, Hashable
{
    static var multitudeValueType: MultitudeValueType { get }
    static var zero: Self { get }

    func convert(target: MultitudeValueType) -> (any MultitudeValue)?
}

public enum MultitudeValueType
{
    case int
    case int8
    case int16
    case int32
    case int64
    case uint
    case uint8
    case uint16
    case uint32
    case uint64
    case float
    case double
}

public enum MultitudeValueVariant
{
    case int(Int)
    case int8(Int8)
    case int16(Int16)
    case int32(Int32)
    case int64(Int64)
    case uint(UInt)
    case uint8(UInt8)
    case uint16(UInt16)
    case uint32(UInt32)
    case uint64(UInt64)
    case float(Float)
    case double(Double)
}

extension Int: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .int
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension Int8: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .int8
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension Int16: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .int16
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension Int32: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .int32
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension Int64: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .int64
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension UInt: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .uint
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension UInt8: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .uint8
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension UInt16: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .uint16
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension UInt32: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .uint32
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension UInt64: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .uint64
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension Float: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .float
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}

extension Double: MultitudeValue
{
    static public var multitudeValueType: MultitudeValueType
    {
        return .double
    }

    static public var zero: Self
    {
        return 0
    }

    public func convert(target: MultitudeValueType) -> (any MultitudeValue)?
    {
        switch target
        {
            case .int:
                return self.int
            case .int8:
                return self.int8
            case .int16:
                return self.int16
            case .int32:
                return self.int32
            case .int64:
                return self.int64
            case .uint:
                return self.uint
            case .uint8:
                return self.uint8
            case .uint16:
                return self.uint16
            case .uint32:
                return self.uint32
            case .uint64:
                return self.uint64
            case .float:
                return self.float
            case .double:
                return self.double
        }
    }
}
