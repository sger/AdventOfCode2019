import UIKit
import XCTest

func readValues() -> [Int] {
    
    var input: [String] = []
    
    if let path = Bundle.main.url(forResource: "input", withExtension: "txt") {
        do {
            input = try String(contentsOf: path).components(separatedBy: "\n")
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
    
    return input.compactMap({ Int($0) })
}

struct Module {
    
    private let mass: [Int]
    
    init(mass: [Int]) {
        self.mass = mass
    }
    
    private func calculateFuel(_ mass: Int) -> Int {
        return (mass / 3) - 2;
    }
    
    private func calculateTotalFuel(_ mass: Int) -> Int {
        let fuel = calculateFuel(mass)
        return fuel <= 0 ? 0 : fuel + calculateTotalFuel(fuel)
    }
    
    func sumFuel() -> Int {
        return mass
            .lazy
            .compactMap({ self.calculateFuel($0) })
            .reduce(0, +)
    }
    
    func sumTotalFuel() -> Int {
        return mass
            .lazy
            .compactMap({ self.calculateTotalFuel($0) })
            .reduce(0, +)
    }
}

let module = Module(mass: readValues())

print(module.sumFuel())
print(module.sumTotalFuel())

class ModuleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSumFuel() {
        let module = Module(mass: [1969])
        XCTAssertEqual(module.sumFuel(), 654)
    }
    
    func testSumTotalFuel() {
        let module = Module(mass: [100756])
        XCTAssertEqual(module.sumFuel(), 33583)
    }
}

ModuleTests.defaultTestSuite.run()
