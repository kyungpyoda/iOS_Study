import Swift

// - Class vs Struct/Enum
struct ValueType {
    var property = 1
}
class ReferenceType {
    var property = 1
}

let firstStructInstance = ValueType()
var secondStructInstance = firstStructInstance
secondStructInstance.property = 2
print("firstStructInstance.property = \(firstStructInstance.property)")
print("secondStructureInstance.property = \(secondStructInstance.property)")

let firstClassInstance = ReferenceType()
var secondClassInstance = firstClassInstance
secondStructInstance.property = 2
print("firstClassInstance.property = \(firstClassInstance.property)")
print("secondClassInstance.property = \(secondClassInstance.property)")

struct SomeStruct {
    var someProperty: String = "Property"
}

var someStructInstance: SomeStruct = SomeStruct()
func someFunc(structInstance: SomeStruct) {
    var localVar: SomeStruct = structInstance
    localVar.someProperty = "My Property has been Changed"
}
someFunc(structInstance: someStructInstance)
print(someStructInstance.someProperty)

class SomeClass {
    var someProperty: String = "Property"
}
var someClassInstance: SomeClass = SomeClass()
func someFunc2(classInstance: SomeClass) {
    var localVar: SomeClass = classInstance
    localVar.someProperty = "My Property has been Changed"
}
someFunc2(classInstance: someClassInstance)
print(someClassInstance.someProperty)


//-Closure
func sumFunction(a: Int, b: Int) -> Int {
    return a + b
}
var sumResult: Int = sumFunction(a: 1, b: 2)
print(sumResult)
var sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a + b
}
sumResult = sum(1, 2)
print(sumResult)
sum = sumFunction(a:b:)
sumResult = sum(1, 2)
print(sumResult)

let add: (Int, Int) -> Int
add = { (a: Int, b: Int) -> Int in
    return a + b
}
let substract: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a - b
}
func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b)
}
var calculated: Int
calculated = calculate(a: 1, b: 3, method: add)
print(calculated)
calculated = calculate(a: 4, b: 1, method: substract)
print(calculated)
calculated = calculate(a: 3, b: 4, method: {(left: Int, right: Int) -> Int in
    return left * right
})
print(calculated)

// - Closure (Advanced)
var result: Int
//후행클로저
result = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
    return left + right
}
//calculate function 의 method 매개변수의 반환타입을 컴파일러도 알기 때문에 클로저에서 굳이 반환타입을 명시해주지 않아도 됨
result = calculate(a: 20, b: 20, method: { (left: Int, right: Int) in
    return left + right
})
//후행클로저 + 반환타입 생략
result = calculate(a: 30, b: 30) { (left: Int, right: Int) in
    return left + right
}
//단축인자이름
result = calculate(a: 40, b: 40, method: {
    return $0 + $1
})
//단축인자이름 + 후행클로저 + 반환타입생략
result = calculate(a:50, b: 50) {
    return $0 + $1
}
//암시적 반환 표현
//클로저가 반환하는 값이 있다면 마지막줄은 암시적으로 반환값으로 취급
result = calculate(a: 1, b: 2) {
    $0 + $1
}
result = calculate(a: 1, b: 2) { $0 + $1 }

// - 프로퍼티
struct Student {
    //인스턴스 저장 프로퍼티
    var name: String = ""
    var `class`: String = "Swift"
    var koreanAge: Int = 0
    
    //인스턴스 연산 프로퍼티
    var westernAge: Int {
        get {
            return koreanAge - 1
        }
        set(inputValue) {
            koreanAge = inputValue + 1
        }
    }
    
    //타입 저장 프로퍼티
    static var typeDescription: String = "학생"
    
    //인스턴스 메서드
    /*
    func selfIntroduce() {
        print("저는 \(class)반 \(name)입니다.")
    }
    */
    var selfIntroduction: String {
        get {
            return "저는 \(self.class)반 \(name)입니다"
        }
    }
    //타입 메서드
    /*
    static func selfIntroduce {
        print("학생타입입니다")
    }
    */
    //읽기전용 타입 연산 프로퍼티
    //읽기전용에서는 get 생략 가능
    static var selfIntroduction: String {
        return "학생타입입니다"
    }
}
print(Student.selfIntroduction)
var pio: Student = Student()
pio.koreanAge = 10
pio.name = "pio"
print(pio.name)
print(pio.selfIntroduction)
print("한국나이 \(pio.koreanAge) 미국나이 \(pio.westernAge)")

struct Money {
    var currencyRate: Double = 1100
    var dollar: Double = 0
    var won: Double {
        get {
            return dollar * currencyRate
        }
        set {
            dollar = newValue / currencyRate
        }
    }
}
var moneyInMyPocket: Money = Money()
moneyInMyPocket.dollar = 10
print(moneyInMyPocket.won)

