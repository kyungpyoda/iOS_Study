import UIKit

var str = "Hello, playground"

//MARK: - Error protocol

enum VendingMachineError: Error {
    case invalidInput
    case insufficientFunds(moneyNeeded: Int)
    case outOfStock
}

class VendingMachine {
    let itemPrice: Int = 100
    var itemCount: Int = 5
    var deposited: Int = 0
    
    func receiveMoney(_ money: Int) throws {
        guard money > 0 else {
            throw VendingMachineError.invalidInput
        }
        
        self.deposited += money
        print("\(money)원 받음")
    }
    func vend(numberOfItems numberOfItemsToVend: Int) throws -> String {
        guard numberOfItemsToVend > 0 else {
            throw VendingMachineError.invalidInput
        }
        guard numberOfItemsToVend * itemPrice <= deposited else {
            let moneyNeeded: Int
            moneyNeeded = numberOfItemsToVend * itemPrice - deposited
            
            throw VendingMachineError.insufficientFunds(moneyNeeded: moneyNeeded)
        }
        guard itemCount >= numberOfItemsToVend else {
            throw VendingMachineError.outOfStock
        }
        
        let totalPrice = numberOfItemsToVend * itemPrice
        
        self.deposited -= totalPrice
        self.itemCount -= numberOfItemsToVend
        
        return "\(numberOfItemsToVend)개 제공함"
    }
}

let machine: VendingMachine = VendingMachine()
var result: String?

do {
    try machine.receiveMoney(0)
} catch VendingMachineError.invalidInput {
    print()
} catch VendingMachineError.insufficientFunds(let moneyNeeded) {
    print()
} catch VendingMachineError.outOfStock {
    print()
}

do {
    result = try machine.vend(numberOfItems: 4)
} catch {
    print(error)
}

result = try? machine.vend(numberOfItems: 0)

//MARK: - 고차함수 Higher-order function
//map, filter, reduce


let numbers: [Int] = [0, 1, 2, 3, 4]
var doubleNumbers: [Int]
var strings: [String]

doubleNumbers = numbers.map({ (number: Int) -> Int in
    return number * 2
})
strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

var filtered: [Int] = [Int]()
let evenNumbers: [Int] = numbers.filter { (number: Int) -> Bool in
    return number % 2 == 0
}

let sum: Int = numbers.reduce(0, { (first: Int, second: Int) -> Int in
    return first + second
})
