import XCTest
@testable import Multitude
@testable import MultitudeArray
@testable import MultitudeSIMD

final class MultitudeTests: XCTestCase
{
    func testMultitudeArrayIntSumTimed() throws
    {
        let _ = Date() // the first Date() call is rumored to be slow, prime Date to get more consistent timings

        let array: [Int] = [Int](repeating: 15, count: 100000000)
        let multitude: Multitude = MultitudeArray<Int>(array: array)

        let start = Date()
        let sumVariant: MultitudeValueVariant = try multitude.sum(type: .int)
        let end = Date()

        switch sumVariant
        {
            case .int(let int):
                print(int)

            default:
                XCTFail()
                return
        }

        let duration = end.timeIntervalSince1970 - start.timeIntervalSince1970
        print(duration)
    }

    func testMultitudeSIMDIntSumTimed() throws
    {
        let _ = Date() // the first Date() call is rumored to be slow, prime Date to get more consistent timings

        let array: [Int] = [Int](repeating: 15, count: 100000000)
        let multitude: Multitude = MultitudeSIMD<Int>(array: array)

        let start = Date()
        let sumVariant: MultitudeValueVariant = try multitude.sum(type: .int)
        let end = Date()

        switch sumVariant
        {
            case .int(let int):
                print(int)

            default:
                XCTFail()
                return
        }

        let duration = end.timeIntervalSince1970 - start.timeIntervalSince1970
        print(duration)
    }

    func testMultitudeSIMDIntSum16() throws
    {
        let array: [Int] = [Int](repeating: 15, count: 16)
        let multitude: Multitude = MultitudeSIMD<Int>(array: array)

        let sumVariant: MultitudeValueVariant = try multitude.sum(type: .int)

        switch sumVariant
        {
            case .int(let int):
                print(int)

            default:
                XCTFail()
                return
        }
    }
}
