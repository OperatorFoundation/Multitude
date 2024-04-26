//
//  Array+SIMD.swift
//
//
//  Created by Dr. Brandon Wiley on 11/15/23.
//

import Foundation

extension Array
{
    func sum_simd() throws -> Element
    {
        guard let first = self.first else
        {
            guard let result = 0 as? Element else
            {
                throw MultitudeSIMDError.badConversion
            }

            return result
        }

        guard self.count > 1 else
        {
            return first
        }

        switch first
        {
            case is Int:
                let result = Int.zero
                guard let typed = result as? Element else
                {
                    throw MultitudeSIMDError.badConversion
                }

                return typed

            default:
                throw MultitudeSIMDError.badConversion
        }
    }
}
