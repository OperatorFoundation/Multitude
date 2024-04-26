//
//  SIMD+Extensions.swift
//  
//
//  Created by Dr. Brandon Wiley on 11/13/23.
//

import Foundation

extension SIMD2
{
    public init(array: [Scalar])
    {
        self.init(array[0], array[1])
    }
}

extension SIMD3
{
    public init(array: [Scalar])
    {
        self.init(array[0], array[1], array[2])
    }
}

extension SIMD4
{
    public init(array: [Scalar])
    {
        self.init(array[0], array[1], array[2], array[3])
    }
}

extension SIMD8
{
    public init(array: [Scalar])
    {
        self.init(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7])
    }
}

extension SIMD16
{
    public init(array: [Scalar])
    {
        self.init(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10], array[11], array[12], array[13], array[14], array[15])
    }
}

extension SIMD32
{
    public init(array values: [Scalar])
    {
        self.init(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31])
    }
}

extension SIMD64
{
    public init(array values: [Scalar])
    {
        self.init(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42], values[43], values[44], values[45], values[46], values[47], values[48], values[49], values[50], values[51], values[52], values[53], values[54], values[55], values[56], values[57], values[58], values[59], values[60], values[61], values[62], values[63])
    }
}
