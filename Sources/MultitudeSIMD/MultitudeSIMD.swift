//
//  MultitudeVector.swift
//
//
//  Created by Dr. Brandon Wiley on 11/12/23.
//

import Foundation
import simd

import Multitude

public class MultitudeSIMD<Internal: MultitudeValue>: Multitude
{
    static public var multitudeValueType: MultitudeValueType
    {
        return Internal.multitudeValueType
    }

    static func slice(array: [Internal], size: Int) -> ([[Internal]], [Internal])
    {
        guard array.count >= size else
        {
            return ([], array)
        }

        var results: [[Internal]] = []

        let whole = array.count / size
        let part = array.count % size

        for chunk in 0..<whole
        {
            let start = chunk * size
            let result = [Internal](array[start..<start+size])
            results.append(result)
        }

        if part > 0
        {
            let start = whole * size
            let rest = [Internal](array[start..<start+part])
            return (results, rest)
        }
        else
        {
            return (results, [])
        }
    }

    let simd64s: [SIMD64<Internal>]
    let simd32s: [SIMD32<Internal>]
    let simd16s: [SIMD16<Internal>]
    let simd8s: [SIMD8<Internal>]
    let simd4s: [SIMD4<Internal>]
    let simd3s: [SIMD3<Internal>]
    let simd2s: [SIMD2<Internal>]
    let element: Internal?

    public init()
    {
        self.simd64s = []
        self.simd32s = []
        self.simd16s = []
        self.simd8s = []
        self.simd4s = []
        self.simd3s = []
        self.simd2s = []
        self.element = nil
    }

    public init(element: Internal)
    {
        self.simd64s = []
        self.simd32s = []
        self.simd16s = []
        self.simd8s = []
        self.simd4s = []
        self.simd3s = []
        self.simd2s = []
        self.element = element
    }

    public required init(array: [Internal])
    {
        guard array.count > 0 else
        {
            self.simd64s = []
            self.simd32s = []
            self.simd16s = []
            self.simd8s = []
            self.simd4s = []
            self.simd3s = []
            self.simd2s = []
            self.element = nil

            return
        }

        guard array.count > 1 else
        {
            self.simd64s = []
            self.simd32s = []
            self.simd16s = []
            self.simd8s = []
            self.simd4s = []
            self.simd3s = []
            self.simd2s = []
            self.element = array[0]

            return
        }

        switch Internal.multitudeValueType
        {
            case .int:
                if Int.bitWidth == Int64.bitWidth
                {
                    self.simd64s = []
                    self.simd32s = []
                    self.simd16s = []
                    let (simd8s, restMax7) = Self.slice(array: array, size: 8)
                    self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                    let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                    self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                    switch restMax3.count
                    {
                        case 3:
                            self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                            self.simd2s = []
                            self.element = nil

                        case 2:
                            self.simd3s = []
                            self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                            self.element = nil

                        case 1:
                            self.simd3s = []
                            self.simd2s = []
                            self.element = restMax3[0]

                        case 0:
                            self.simd3s = []
                            self.simd2s = []
                            self.element = nil

                        default: // This should not happen.
                            self.simd3s = []
                            self.simd2s = []
                            self.element = nil
                    }
                }
                else // if Int.bidWidth == Int32.bitWidth
                {
                    self.simd64s = []
                    self.simd32s = []
                    let (simd16s, restMax15) = Self.slice(array: array, size: 16)
                    self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                    let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                    self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                    let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                    self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                    switch restMax3.count
                    {
                        case 3:
                            self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                            self.simd2s = []
                            self.element = nil

                        case 2:
                            self.simd3s = []
                            self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                            self.element = nil

                        case 1:
                            self.simd3s = []
                            self.simd2s = []
                            self.element = restMax3[0]

                        case 0:
                            self.simd3s = []
                            self.simd2s = []
                            self.element = nil

                        default: // This should not happen.
                            self.simd3s = []
                            self.simd2s = []
                            self.element = nil
                    }
                }

            case .int64:
                self.simd64s = []
                self.simd32s = []
                self.simd16s = []
                let (simd8s, restMax7) = Self.slice(array: array, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .int32:
                self.simd64s = []
                self.simd32s = []
                let (simd16s, restMax15) = Self.slice(array: array, size: 16)
                self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .int16:
                self.simd64s = []

                let (simd32s, restMax31) = Self.slice(array: array, size: 32)
                self.simd32s = simd32s.map { SIMD32<Internal>(array: $0) }

                let (simd16s, restMax15) = Self.slice(array: restMax31, size: 16)
                self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .int8:
                let (simd64s, restMax63) = Self.slice(array: array, size: 64)
                self.simd64s = simd64s.map { SIMD64<Internal>(array: $0) }

                let (simd32s, restMax31) = Self.slice(array: restMax63, size: 32)
                self.simd32s = simd32s.map { SIMD32<Internal>(array: $0) }

                let (simd16s, restMax15) = Self.slice(array: restMax31, size: 16)
                self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .uint:
                if UInt.bitWidth == UInt64.bitWidth
                {
                    self.simd64s = []
                    self.simd32s = []
                    self.simd16s = []
                    let (simd8s, restMax7) = Self.slice(array: array, size: 8)
                    self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                    let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                    self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                    switch restMax3.count
                    {
                        case 3:
                            self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                            self.simd2s = []
                            self.element = nil

                        case 2:
                            self.simd3s = []
                            self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                            self.element = nil

                        case 1:
                            self.simd3s = []
                            self.simd2s = []
                            self.element = restMax3[0]

                        case 0:
                            self.simd3s = []
                            self.simd2s = []
                            self.element = nil

                        default: // This should not happen.
                            self.simd3s = []
                            self.simd2s = []
                            self.element = nil
                    }
                }
                else // if UInt.bidWidth == UInt32.bitWidth
                {
                    self.simd64s = []
                    self.simd32s = []
                    let (simd16s, restMax15) = Self.slice(array: array, size: 16)
                    self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                    let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                    self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                    let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                    self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                    switch restMax3.count
                    {
                        case 3:
                            self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                            self.simd2s = []
                            self.element = nil

                        case 2:
                            self.simd3s = []
                            self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                            self.element = nil

                        case 1:
                            self.simd3s = []
                            self.simd2s = []
                            self.element = restMax3[0]

                        case 0:
                            self.simd3s = []
                            self.simd2s = []
                            self.element = nil

                        default: // This should not happen.
                            self.simd3s = []
                            self.simd2s = []
                            self.element = nil
                    }
                }

            case .uint64:
                self.simd64s = []
                self.simd32s = []
                self.simd16s = []
                let (simd8s, restMax7) = Self.slice(array: array, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .uint32:
                self.simd64s = []
                self.simd32s = []
                let (simd16s, restMax15) = Self.slice(array: array, size: 16)
                self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .uint16:
                self.simd64s = []

                let (simd32s, restMax31) = Self.slice(array: array, size: 32)
                self.simd32s = simd32s.map { SIMD32<Internal>(array: $0) }

                let (simd16s, restMax15) = Self.slice(array: restMax31, size: 16)
                self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .uint8:
                let (simd64s, restMax63) = Self.slice(array: array, size: 64)
                self.simd64s = simd64s.map { SIMD64<Internal>(array: $0) }

                let (simd32s, restMax31) = Self.slice(array: restMax63, size: 32)
                self.simd32s = simd32s.map { SIMD32<Internal>(array: $0) }

                let (simd16s, restMax15) = Self.slice(array: restMax31, size: 16)
                self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .float:
                self.simd64s = []
                self.simd32s = []
                let (simd16s, restMax15) = Self.slice(array: array, size: 16)
                self.simd16s = simd16s.map { SIMD16<Internal>(array: $0) }

                let (simd8s, restMax7) = Self.slice(array: restMax15, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }

            case .double:
                self.simd64s = []
                self.simd32s = []
                self.simd16s = []
                let (simd8s, restMax7) = Self.slice(array: array, size: 8)
                self.simd8s = simd8s.map { SIMD8<Internal>(array: $0) }

                let (simd4s, restMax3) = Self.slice(array: restMax7, size: 4)
                self.simd4s = simd4s.map { SIMD4<Internal>(array: $0) }

                switch restMax3.count
                {
                    case 3:
                        self.simd3s = [SIMD3<Internal>(restMax3[0], restMax3[1], restMax3[2])]
                        self.simd2s = []
                        self.element = nil

                    case 2:
                        self.simd3s = []
                        self.simd2s = [SIMD2<Internal>(restMax3[0], restMax3[1])]
                        self.element = nil

                    case 1:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = restMax3[0]

                    case 0:
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil

                    default: // This should not happen.
                        self.simd3s = []
                        self.simd2s = []
                        self.element = nil
                }
        }
    }

    public func length() -> Int
    {
        return (self.simd64s.count * 64) + (self.simd32s.count * 32) + (self.simd16s.count * 16) + (self.simd8s.count * 8) + (self.simd4s.count * 4) + (self.simd3s.count * 3) + (self.simd2s.count * 2) + (self.element == nil ? 0 : 1)
    }

    public func get(index: Int, type: MultitudeValueType) throws -> MultitudeValueVariant
    {
        guard index >= 0, index < self.length() else
        {
            throw MultitudeSIMDError.badIndex(index)
        }

        let internalType = try self.getInternal(index)

        guard let converted = internalType.convert(target: type) else
        {
            throw MultitudeSIMDError.badConversion
        }

        switch type
        {
            case .int:
                guard let result = converted as? Int else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int(result)

            case .int8:
                guard let result = converted as? Int8 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int8(result)

            case .int16:
                guard let result = converted as? Int16 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int16(result)

            case .int32:
                guard let result = converted as? Int32 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int32(result)

            case .int64:
                guard let result = converted as? Int64 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int64(result)

            case .uint:
                guard let result = converted as? UInt else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint(result)

            case .uint8:
                guard let result = converted as? UInt8 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint8(result)

            case .uint16:
                guard let result = converted as? UInt16 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint16(result)

            case .uint32:
                guard let result = converted as? UInt32 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint32(result)

            case .uint64:
                guard let result = converted as? UInt64 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint64(result)

            case .float:
                guard let result = converted as? Float else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .float(result)

            case .double:
                guard let result = converted as? Double else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .double(result)
        }
    }

    func getInternal(_ index: Int) throws -> Internal
    {
        guard index >= 0, index < self.length() else
        {
            throw MultitudeSIMDError.badIndex(index)
        }

        guard self.length() > 1 else
        {
            if let element = self.element
            {
                return element
            }
            else
            {
                throw MultitudeSIMDError.badIndex(index)
            }
        }

        var current = index
        for simd64 in self.simd64s
        {
            if current < 64
            {
                return simd64[current]
            }
            else
            {
                current -= 64
            }
        }

        for simd32 in self.simd32s
        {
            if current < 32
            {
                return simd32[current]
            }
            else
            {
                current -= 32
            }
        }

        for simd16 in self.simd16s
        {
            if current < 16
            {
                return simd16[current]
            }
            else
            {
                current -= 16
            }
        }

        for simd8 in self.simd16s
        {
            if current < 8
            {
                return simd8[current]
            }
            else
            {
                current -= 8
            }
        }

        for simd4 in self.simd16s
        {
            if current < 4
            {
                return simd4[current]
            }
            else
            {
                current -= 4
            }
        }

        for simd3 in self.simd16s
        {
            if current < 3
            {
                return simd3[current]
            }
            else
            {
                current -= 3
            }
        }

        for simd2 in self.simd16s
        {
            if current < 2
            {
                return simd2[current]
            }
            else
            {
                current -= 2
            }
        }

        throw MultitudeSIMDError.badIndex(index)
    }

    public func sum(type: MultitudeValueType) throws -> MultitudeValueVariant
    {
        guard self.length() > 0 else
        {
            switch type
            {
                case .int:
                    return .int(Int.zero)

                case .int8:
                    return .int8(Int8.zero)

                case .int16:
                    return .int16(Int16.zero)

                case .int32:
                    return .int32(Int32.zero)

                case .int64:
                    return .int64(Int64.zero)

                case .uint:
                    return .uint(UInt.zero)

                case .uint8:
                    return .uint8(UInt8.zero)

                case .uint16:
                    return .uint16(UInt16.zero)

                case .uint32:
                    return .uint32(UInt32.zero)

                case .uint64:
                    return .uint64(UInt64.zero)

                case .float:
                    return .float(Float.zero)

                case .double:
                    return .double(Double.zero)
            }
        }

        guard self.length() > 1 else
        {
            if let element = self.element
            {
                switch type
                {
                    case .int:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? Int else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .int(result)

                    case .int8:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? Int8 else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .int8(result)

                    case .int16:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? Int16 else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .int16(result)

                    case .int32:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? Int32 else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .int32(result)

                    case .int64:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? Int64 else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .int64(result)

                    case .uint:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? UInt else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .uint(result)

                    case .uint8:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? UInt8 else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .uint8(result)

                    case .uint16:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? UInt16 else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .uint16(result)

                    case .uint32:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? UInt32 else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .uint32(result)

                    case .uint64:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? UInt64 else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .uint64(result)

                    case .float:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? Float else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .float(result)

                    case .double:
                        guard let converted = element.convert(target: type) else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        guard let result = converted as? Double else
                        {
                            throw MultitudeSIMDError.badConversion
                        }

                        return .double(result)
                }
            }
            else
            {
                switch type
                {
                    case .int:
                        return .int(Int.zero)

                    case .int8:
                        return .int8(Int8.zero)

                    case .int16:
                        return .int16(Int16.zero)

                    case .int32:
                        return .int32(Int32.zero)

                    case .int64:
                        return .int64(Int64.zero)

                    case .uint:
                        return .uint(UInt.zero)

                    case .uint8:
                        return .uint8(UInt8.zero)

                    case .uint16:
                        return .uint16(UInt16.zero)

                    case .uint32:
                        return .uint32(UInt32.zero)

                    case .uint64:
                        return .uint64(UInt64.zero)

                    case .float:
                        return .float(Float.zero)

                    case .double:
                        return .double(Double.zero)
                }
            }
        }

        return try reducedSum(type: type)
    }

    func reducedSimdSum<T: SIMD>(vector: T) throws -> T.Scalar where T.Scalar == Internal
    {
        switch vector
        {
            case let simd2 as SIMD2<Int>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<Int>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<Int>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<Int>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            // No sim16, simd32, simd64 for Int. This would technically depend on if Int is Int64 or Int32,
            // but I don't know how to write this.

            case let simd2 as SIMD2<Int32>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<Int32>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<Int32>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<Int32>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd16 as SIMD16<Int32>:
                let scalar = simd_reduce_add(simd16)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
                // No simd32, simd64 for Int32.

            case let simd2 as SIMD2<Int16>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<Int16>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<Int16>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<Int16>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd16 as SIMD16<Int16>:
                let scalar = simd_reduce_add(simd16)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd32 as SIMD32<Int16>:
                let scalar = simd_reduce_add(simd32)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            // No simd64 for Int16.

            case let simd2 as SIMD2<Int8>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<Int8>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<Int8>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<Int8>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd16 as SIMD16<Int8>:
                let scalar = simd_reduce_add(simd16)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd32 as SIMD32<Int8>:
                let scalar = simd_reduce_add(simd32)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd64 as SIMD64<Int8>:
                let scalar = simd_reduce_add(simd64)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result

            case let simd2 as SIMD2<UInt>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<UInt>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<UInt>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<UInt>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
                // No sim16, simd32, simd64 for UInt. This would technically depend on if Int is Int64 or Int32,
                // but I don't know how to write this.

            case let simd2 as SIMD2<UInt32>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<UInt32>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<UInt32>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<UInt32>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd16 as SIMD16<UInt32>:
                let scalar = simd_reduce_add(simd16)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            // No simd32, simd64 for UInt32.

            case let simd2 as SIMD2<UInt16>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<UInt16>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<UInt16>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<UInt16>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd16 as SIMD16<UInt16>:
                let scalar = simd_reduce_add(simd16)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd32 as SIMD32<UInt16>:
                let scalar = simd_reduce_add(simd32)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
                // No simd64 for UInt16.

            case let simd2 as SIMD2<Float>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<Float>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<Float>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<Float>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd16 as SIMD16<Float>:
                let scalar = simd_reduce_add(simd16)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result

            case let simd2 as SIMD2<Double>:
                let scalar = simd_reduce_add(simd2)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd3 as SIMD3<Double>:
                let scalar = simd_reduce_add(simd3)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd4 as SIMD4<Double>:
                let scalar = simd_reduce_add(simd4)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result
            case let simd8 as SIMD8<Double>:
                let scalar = simd_reduce_add(simd8)
                guard let result = scalar as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                return result

            default:
                throw MultitudeSIMDError.badConversion
        }
    }

    func convert(value: any MultitudeValue, type: MultitudeValueType) throws -> MultitudeValueVariant
    {
        switch type
        {
            case .int:
                guard let converted = value.convert(target: .int) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? Int else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int(typed)

            case .int64:
                guard let converted = value.convert(target: .int64) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? Int64 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int64(typed)

            case .int32:
                guard let converted = value.convert(target: .int32) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? Int32 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int32(typed)

            case .int16:
                guard let converted = value.convert(target: .int16) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? Int16 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int16(typed)

            case .int8:
                guard let converted = value.convert(target: .int8) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? Int8 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .int8(typed)

            case .uint:
                guard let converted = value.convert(target: .uint) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? UInt else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint(typed)

            case .uint64:
                guard let converted = value.convert(target: .uint64) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? UInt64 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint64(typed)

            case .uint32:
                guard let converted = value.convert(target: .uint32) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? UInt32 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint32(typed)

            case .uint16:
                guard let converted = value.convert(target: .uint16) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? UInt16 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint16(typed)

            case .uint8:
                guard let converted = value.convert(target: .uint8) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? UInt8 else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .uint8(typed)

            case .float:
                guard let converted = value.convert(target: .float) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? Float else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .float(typed)

            case .double:
                guard let converted = value.convert(target: .double) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                guard let typed = converted as? Double else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return .double(typed)
        }
    }

    func reducedSum(type: MultitudeValueType) throws -> MultitudeValueVariant
    {
        switch Internal.multitudeValueType
        {
            case .int:
                if Int.bitWidth == Int64.bitWidth
                {
                    let result: Int64 = try self.reduceSumInt64()
                    return try self.convert(value: result, type: type)
                }
                else
                {
                    throw MultitudeSIMDError.badConversion
//                    let result: Int32 = try self.reduceSumInt32()
//                    return self.convert(value: result, type: type)
                }

            case .int64:
                let result: Int64 = try self.reduceSumInt64()
                return try self.convert(value: result, type: type)

//            case .int32:
//                let result: Int32 = try self.reduceSumInt32()
//                return self.convert(value: result, type: type)

            default:
                throw MultitudeSIMDError.badConversion

//
//            case .int8:
//                let sum64s = try simd64s.map
//                {
//                    simd64 in
//
//                    guard let char64 = simd64 as? simd_char64 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(char64)
//                }
//
//                let sum32s = try simd32s.map
//                {
//                    simd32 in
//
//                    guard let char32 = simd32 as? simd_char32 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(char32)
//                }
//
//                let sum16s = try simd16s.map
//                {
//                    simd16 in
//
//                    guard let char16 = simd16 as? simd_char16 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(char16)
//                }
//
//                let sum8s = try simd8s.map
//                {
//                    simd8 in
//
//                    guard let char8 = simd8 as? simd_char8 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(char8)
//                }
//
//                let sum4s = try simd4s.map
//                {
//                    simd4 in
//
//                    guard let char4 = simd4 as? simd_char4 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(char4)
//                }
//
//                let sum3s = try simd3s.map
//                {
//                    simd3 in
//
//                    guard let char3 = simd3 as? simd_char3 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(char3)
//                }
//
//                let sum2s = try simd2s.map
//                {
//                    simd2 in
//
//                    guard let char2 = simd2 as? simd_char2 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(char2)
//                }
//
//                let elementValue: Internal
//                if let element = self.element
//                {
//                    let elementValue = element
//                }
//                else
//                {
//                    elementValue = Internal.zero
//                }
//
//                let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                let sumMultitude = MultitudeSIMD(array: sums)
//                return sumMultitude.sum(type: type)
//
//            case .uint:
//                if UInt.bitWidth == UInt64.bitWidth
//                {
//                    let sum64s: [Internal] = []
//                    let sum32s: [Internal] = []
//                    let sum16s: [Internal] = []
//
//                    let sum8s = try simd8s.map
//                    {
//                        simd8 in
//
//                        guard let ulong8 = simd8 as? simd_ulong8 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(ulong8)
//                    }
//
//                    let sum4s = try simd4s.map
//                    {
//                        simd4 in
//
//                        guard let ulong4 = simd4 as? simd_ulong4 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(ulong4)
//                    }
//
//                    let sum3s = try simd3s.map
//                    {
//                        simd3 in
//
//                        guard let ulong3 = simd3 as? simd_ulong3 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(ulong3)
//                    }
//
//                    let sum2s = try simd2s.map
//                    {
//                        simd2 in
//
//                        guard let ulong2 = simd2 as? simd_ulong2 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(ulong2)
//                    }
//
//                    let elementValue: Internal
//                    if let element = self.element
//                    {
//                        let elementValue = element
//                    }
//                    else
//                    {
//                        elementValue = Internal.zero
//                    }
//
//                    let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                    let sumMultitude = MultitudeSIMD(array: sums)
//                    return sumMultitude.sum(type: type)
//                }
//                else // if Int.bidWidth == UInt32.bitwidth
//                {
//                    let sum64s: [Internal] = []
//                    let sum32s: [Internal] = []
//
//                    let sum16s = try simd16s.map
//                    {
//                        simd16 in
//
//                        guard let uint16 = simd16 as? simd_uint16 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(uint16)
//                    }
//
//                    let sum8s = try simd8s.map
//                    {
//                        simd8 in
//
//                        guard let uint8 = simd8 as? simd_uint8 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(uint8)
//                    }
//
//                    let sum4s = try simd4s.map
//                    {
//                        simd4 in
//
//                        guard let uint4 = simd4 as? simd_uint4 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(uint4)
//                    }
//
//                    let sum3s = try simd3s.map
//                    {
//                        simd3 in
//
//                        guard let uint3 = simd3 as? simd_uint3 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(uint3)
//                    }
//
//                    let sum2s = try simd2s.map
//                    {
//                        simd2 in
//
//                        guard let uint2 = simd2 as? simd_uint2 else
//                        {
//                            throw MultitudeSIMDError.badConversion
//                        }
//
//                        return simd_reduce_add(uint2)
//                    }
//
//                    let elementValue: Internal
//                    if let element = self.element
//                    {
//                        let elementValue = element
//                    }
//                    else
//                    {
//                        elementValue = Internal.zero
//                    }
//
//                    let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                    let sumMultitude = MultitudeSIMD(array: sums)
//                    return sumMultitude.sum(type: type)
//                }
//
//            case .uint64:
//                let sum64s: [Internal] = []
//                let sum32s: [Internal] = []
//                let sum16s: [Internal] = []
//
//                let sum8s = try simd8s.map
//                {
//                    simd8 in
//
//                    guard let ulong8 = simd8 as? simd_ulong8 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ulong8)
//                }
//
//                let sum4s = try simd4s.map
//                {
//                    simd4 in
//
//                    guard let ulong4 = simd4 as? simd_ulong4 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ulong4)
//                }
//
//                let sum3s = try simd3s.map
//                {
//                    simd3 in
//
//                    guard let ulong3 = simd3 as? simd_ulong3 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ulong3)
//                }
//
//                let sum2s = try simd2s.map
//                {
//                    simd2 in
//
//                    guard let ulong2 = simd2 as? simd_ulong2 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ulong2)
//                }
//
//                let elementValue: Internal
//                if let element = self.element
//                {
//                    let elementValue = element
//                }
//                else
//                {
//                    elementValue = Internal.zero
//                }
//
//                let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                let sumMultitude = MultitudeSIMD(array: sums)
//                return sumMultitude.sum(type: type)
//
//            case .uint32:
//                let sum64s: [Internal] = []
//                let sum32s: [Internal] = []
//
//                let sum16s = try simd16s.map
//                {
//                    simd16 in
//
//                    guard let uint16 = simd16 as? simd_uint16 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uint16)
//                }
//
//                let sum8s = try simd8s.map
//                {
//                    simd8 in
//
//                    guard let uint8 = simd8 as? simd_uint8 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uint8)
//                }
//
//                let sum4s = try simd4s.map
//                {
//                    simd4 in
//
//                    guard let uint4 = simd4 as? simd_uint4 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uint4)
//                }
//
//                let sum3s = try simd3s.map
//                {
//                    simd3 in
//
//                    guard let uint3 = simd3 as? simd_uint3 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uint3)
//                }
//
//                let sum2s = try simd2s.map
//                {
//                    simd2 in
//
//                    guard let uint2 = simd2 as? simd_uint2 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uint2)
//                }
//
//                let elementValue: Internal
//                if let element = self.element
//                {
//                    let elementValue = element
//                }
//                else
//                {
//                    elementValue = Internal.zero
//                }
//
//                let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                let sumMultitude = MultitudeSIMD(array: sums)
//                return sumMultitude.sum(type: type)
//
//            case .uint16:
//                let sum64s: [Internal] = []
//
//                let sum32s = try simd32s.map
//                {
//                    simd32 in
//
//                    guard let ushort32 = simd32 as? simd_ushort32 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ushort32)
//                }
//
//                let sum16s = try simd16s.map
//                {
//                    simd16 in
//
//                    guard let ushort16 = simd16 as? simd_ushort16 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ushort16)
//                }
//
//                let sum8s = try simd8s.map
//                {
//                    simd8 in
//
//                    guard let ushort8 = simd8 as? simd_ushort8 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ushort8)
//                }
//
//                let sum4s = try simd4s.map
//                {
//                    simd4 in
//
//                    guard let ushort4 = simd4 as? simd_ushort4 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ushort4)
//                }
//
//                let sum3s = try simd3s.map
//                {
//                    simd3 in
//
//                    guard let ushort3 = simd3 as? simd_ushort3 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ushort3)
//                }
//
//                let sum2s = try simd2s.map
//                {
//                    simd2 in
//
//                    guard let ushort2 = simd2 as? simd_ushort2 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(ushort2)
//                }
//
//                let elementValue: Internal
//                if let element = self.element
//                {
//                    let elementValue = element
//                }
//                else
//                {
//                    elementValue = Internal.zero
//                }
//
//                let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                let sumMultitude = MultitudeSIMD(array: sums)
//                return sumMultitude.sum(type: type)
//
//            case .uint8:
//                let sum64s = try simd64s.map
//                {
//                    simd64 in
//
//                    guard let uchar64 = simd64 as? simd_uchar64 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uchar64)
//                }
//
//                let sum32s = try simd32s.map
//                {
//                    simd32 in
//
//                    guard let uchar32 = simd32 as? simd_uchar32 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uchar32)
//                }
//
//                let sum16s = try simd16s.map
//                {
//                    simd16 in
//
//                    guard let uchar16 = simd16 as? simd_uchar16 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uchar16)
//                }
//
//                let sum8s = try simd8s.map
//                {
//                    simd8 in
//
//                    guard let uchar8 = simd8 as? simd_uchar8 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uchar8)
//                }
//
//                let sum4s = try simd4s.map
//                {
//                    simd4 in
//
//                    guard let uchar4 = simd4 as? simd_uchar4 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uchar4)
//                }
//
//                let sum3s = try simd3s.map
//                {
//                    simd3 in
//
//                    guard let uchar3 = simd3 as? simd_uchar3 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uchar3)
//                }
//
//                let sum2s = try simd2s.map
//                {
//                    simd2 in
//
//                    guard let uchar2 = simd2 as? simd_uchar2 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(uchar2)
//                }
//
//                let elementValue: Internal
//                if let element = self.element
//                {
//                    let elementValue = element
//                }
//                else
//                {
//                    elementValue = Internal.zero
//                }
//
//                let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                let sumMultitude = MultitudeSIMD(array: sums)
//                return sumMultitude.sum(type: type)
//
//            case .float:
//                let sum64s: [Internal] = []
//                let sum32s: [Internal] = []
//
//                let sum16s = try simd16s.map
//                {
//                    simd16 in
//
//                    guard let float16 = simd16 as? simd_float16 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(float16)
//                }
//
//                let sum8s = try simd8s.map
//                {
//                    simd8 in
//
//                    guard let float8 = simd8 as? simd_float8 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(float8)
//                }
//
//                let sum4s = try simd4s.map
//                {
//                    simd4 in
//
//                    guard let float4 = simd4 as? simd_float4 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(float4)
//                }
//
//                let sum3s = try simd3s.map
//                {
//                    simd3 in
//
//                    guard let float3 = simd3 as? simd_float3 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(float3)
//                }
//
//                let sum2s = try simd2s.map
//                {
//                    simd2 in
//
//                    guard let float2 = simd2 as? simd_float2 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(float2)
//                }
//
//                let elementValue: Internal
//                if let element = self.element
//                {
//                    let elementValue = element
//                }
//                else
//                {
//                    elementValue = Internal.zero
//                }
//
//                let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                let sumMultitude = MultitudeSIMD(array: sums)
//                return sumMultitude.sum(type: type)
//
//            case .double:
//                let sum64s: [Internal] = []
//                let sum32s: [Internal] = []
//                let sum16s: [Internal] = []
//
//                let sum8s = try simd8s.map
//                {
//                    simd8 in
//
//                    guard let double8 = simd8 as? simd_double8 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(double8)
//                }
//
//                let sum4s = try simd4s.map
//                {
//                    simd4 in
//
//                    guard let double4 = simd4 as? simd_double4 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(double4)
//                }
//
//                let sum3s = try simd3s.map
//                {
//                    simd3 in
//
//                    guard let double3 = simd3 as? simd_double3 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(double3)
//                }
//
//                let sum2s = try simd2s.map
//                {
//                    simd2 in
//
//                    guard let double2 = simd2 as? simd_double2 else
//                    {
//                        throw MultitudeSIMDError.badConversion
//                    }
//
//                    return simd_reduce_add(double2)
//                }
//
//                let elementValue: Internal
//                if let element = self.element
//                {
//                    let elementValue = element
//                }
//                else
//                {
//                    elementValue = Internal.zero
//                }
//
//                let sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + elementValue
//                let sumMultitude = MultitudeSIMD(array: sums)
//                return sumMultitude.sum(type: type)
        }
    }

    func reduceSumInt64() throws -> Int64
    {
        let sum64s: [Internal] = []
        let sum32s: [Internal] = []
        let sum16s: [Internal] = []

        let sum8s: [Internal] = try simd8s.map
        {
            simd8 in

            guard let long8 = simd8 as? simd_long8 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(long8)

            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum4s: [Internal] = try simd4s.map
        {
            simd4 in

            guard let long4 = simd4 as? simd_long4 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(long4)

            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum3s: [Internal] = try simd3s.map
        {
            simd3 in

            guard let long3 = simd3 as? simd_long3 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(long3)

            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum2s: [Internal] = try simd2s.map
        {
            simd2 in

            guard let long2 = simd2 as? simd_long2 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(long2)

            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        var sums: [Internal]
        if let element = self.element
        {
            sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + [element]
        }
        else
        {
            sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s
        }

        var newSums: [Internal] = []
        while sums.count >= 8
        {
            let whole = sums.count / 8
            let part = sums.count % 8

            for chunk in 0..<whole
            {
                let start: Int = chunk * 8
                guard let vector = SIMD8<Internal>(sums[start], sums[start+1], sums[start+2], sums[start+3], sums[start+4], sums[start+5], sums[start+6], sums[start+7]) as? simd_long8 else
                {
                    throw MultitudeSIMDError.badConversion
                }
                guard let newSum = simd_reduce_add(vector) as? Internal else
                {
                    throw MultitudeSIMDError.badConversion
                }
                newSums.append(newSum)
                sums = newSums
            }
        }

        let sumMultitude: MultitudeSIMD<Internal> = MultitudeSIMD(array: sums)
        let result: MultitudeValueVariant = try sumMultitude.sum(type: .int64)
        switch result
        {
            case .int64(let int64):
                return int64

            default:
                throw MultitudeSIMDError.badConversion
        }
    }

    func reduceSumInt32() throws -> Int32
    {
        let sum64s: [Internal] = []
        let sum32s: [Internal] = []

        let sum16s: [Internal] = try simd16s.map
        {
            simd16 in

            guard let int16 = simd16 as? simd_int16 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(int16)

            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum8s: [Internal] = try simd8s.map
        {
            simd8 in

            guard let int8 = simd8 as? simd_int8 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(int8)

            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum4s: [Internal] = try simd4s.map
        {
            simd4 in

            guard let int4 = simd4 as? simd_int4 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(int4)

            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum3s: [Internal] = try simd3s.map
        {
            simd3 in

            guard let int3 = simd3 as? simd_int3 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(int3)
            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum2s: [Internal] = try simd2s.map
        {
            simd2 in

            guard let int2 = simd2 as? simd_int2 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(int2)
            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sums: [Internal]
        if let element = self.element
        {
            sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + [element]
        }
        else
        {
            sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s
        }

        let sumMultitude = MultitudeSIMD(array: sums)
        let result: MultitudeValueVariant = try sumMultitude.sum(type: .int32)
        switch result
        {
            case .int32(let int32):
                return int32

            default:
                throw MultitudeSIMDError.badConversion
        }
    }

    func reduceSumInt16() throws -> Int16
    {
        let sum64s: [Internal] = []

        let sum32s: [Internal] = try simd32s.map
        {
            simd32 in

            guard let short32 = simd32 as? simd_short32 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(short32)
            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result       
        }

        let sum16s: [Internal] = try simd16s.map
        {
            simd16 in

            guard let short16 = simd16 as? simd_short16 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(short16)
            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum8s: [Internal] = try simd8s.map
        {
            simd8 in

            guard let short8 = simd8 as? simd_short8 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(short8)
            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum4s: [Internal] = try simd4s.map
        {
            simd4 in

            guard let short4 = simd4 as? simd_short4 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(short4)
            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum3s: [Internal] = try simd3s.map
        {
            simd3 in

            guard let short3 = simd3 as? simd_short3 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(short3)
            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sum2s: [Internal] = try simd2s.map
        {
            simd2 in

            guard let short2 = simd2 as? simd_short2 else
            {
                throw MultitudeSIMDError.badConversion
            }

            let sum = simd_reduce_add(short2)
            guard let result = sum as? Internal else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        let sums: [Internal]
        if let element = self.element
        {
            sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s + [element]
        }
        else
        {
            sums = sum64s + sum32s + sum16s + sum8s + sum4s + sum3s + sum2s
        }
        
        let sumMultitude = MultitudeSIMD(array: sums)
        let result: MultitudeValueVariant = try sumMultitude.sum(type: .int16)
        switch result
        {
            case .int16(let int16):
                return int16

            default:
                throw MultitudeSIMDError.badConversion
        }
    }

    public func append(value: any MultitudeValue) throws -> Self
    {
        guard let internalType = value.convert(target: Internal.multitudeValueType) as? Internal else
        {
            throw MultitudeSIMDError.badConversion
        }

        let oldArray = try self.array(type: Internal.multitudeValueType)

        guard let typed = oldArray as? [Internal] else
        {
            throw MultitudeSIMDError.badConversion
        }

        let newArray: [Internal] = [internalType]

        let resultArray: [Internal] = typed + newArray
        return Self(array: resultArray)
    }

    public func join(other: any Multitude) throws -> Self
    {
        guard let oldArray = try self.array(type: Internal.multitudeValueType) as? [Internal] else
        {
            throw MultitudeSIMDError.badConversion
        }

        guard let otherArray = try other.array(type: Internal.multitudeValueType) as? [Internal] else
        {
            throw MultitudeSIMDError.badConversion
        }

        let newArray: [Internal] = oldArray + otherArray
        return Self(array: newArray)
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
                        throw MultitudeSIMDError.badConversion
                    }

                    newArray.append(value)

                default:
                    throw MultitudeSIMDError.badConversion
            }
        }

        return Self(array: newArray)
    }

    public func replicate(repeats: Int) throws -> Self
    {
        if repeats == self.length()
        {
            let oldArray = try self.array(type: Internal.multitudeValueType)

            guard let typed = oldArray as? [Internal] else
            {
                throw MultitudeSIMDError.badConversion
            }

            let newArray: [Internal] = typed + typed
            return Self(array: typed + newArray)
        }
        else if repeats > self.length()
        {
            let whole = repeats / self.length()
            let part = repeats % self.length()

            let oldArray = try self.array(type: Internal.multitudeValueType)

            guard let typed = oldArray as? [Internal] else
            {
                throw MultitudeSIMDError.badConversion
            }

            var newArray: [Internal] = []

            for _ in 0..<whole
            {
                newArray += typed
            }

            if part > 0
            {
                newArray += [Internal](typed[0..<part])
            }

            return Self(array: typed + newArray)
        }
        else // if repeats < self.length()
        {
            let oldArray = try self.array(type: Internal.multitudeValueType)

            guard let typed = oldArray as? [Internal] else
            {
                throw MultitudeSIMDError.badConversion
            }

            let newArray = [Internal](typed[0..<repeats])
            return Self(array: typed + newArray)
        }
    }

    public func map<Result: MultitudeValue>(_ f: (any MultitudeValue) throws -> Result) throws -> any Multitude
    {
        let newArray = try self.array(type: Internal.multitudeValueType).map
        {
            value in

            return try f(value)
        }

        return MultitudeSIMD<Result>(array: newArray)
    }

    public func array(type: MultitudeValueType) throws -> [any MultitudeValue]
    {
        if type == Internal.multitudeValueType
        {
            var results: [Internal] = []

            for simd64 in self.simd64s
            {
                for index in 0..<64
                {
                    results.append(simd64[index])
                }
            }

            for simd32 in self.simd32s
            {
                for index in 0..<32
                {
                    results.append(simd32[index])
                }
            }

            for simd16 in self.simd16s
            {
                for index in 0..<16
                {
                    results.append(simd16[index])
                }
            }

            for simd8 in self.simd8s
            {
                for index in 0..<8
                {
                    results.append(simd8[index])
                }
            }

            for simd4 in self.simd4s
            {
                for index in 0..<4
                {
                    results.append(simd4[index])
                }
            }

            for simd3 in self.simd3s
            {
                for index in 0..<3
                {
                    results.append(simd3[index])
                }
            }

            for simd2 in self.simd2s
            {
                for index in 0..<2
                {
                    results.append(simd2[index])
                }
            }

            if let element = self.element
            {
                results.append(element)
            }

            return results
        }
        else
        {
            return try self.array(type: Internal.multitudeValueType).map
            {
                value in

                guard let converted = value.convert(target: type) else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return converted
            }
        }
    }
}

public enum MultitudeSIMDError: Error
{
    case badConversion
    case badIndex(Int)
}
