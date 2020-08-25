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
    let localVar: SomeClass = classInstance
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

// - 프로퍼티 감시자 사용
struct Money2 {
    var currencyRate: Double = 1100 {
        willSet(newRate) {
            print("환율이 \(currencyRate)에서 \(newRate)으로 변경될 예정입니다.")
        }
        didSet(oldRate) {
            print("환율이 \(oldRate)에서 \(currencyRate)으로 변경되었습니다.")
        }
    }
    var dollar: Double = 0 {
        willSet {
            print("\(dollar)에서 \(newValue)달러로 변경될 예정입니다.")
        }
        didSet {
            print("\(oldValue)달러에서 \(dollar)달러로 변경되었습니다.")
        }
    }
    var won: Double {
        get {
            return dollar * currencyRate
        }
        set {
            dollar = newValue / currencyRate
        }
        
        //프로퍼티 감시자와 연산 프로퍼티 기능은 동시 사용 불가
    }
}
var moneyInMyPocket2: Money2 = Money2()
moneyInMyPocket2.currencyRate = 1150
moneyInMyPocket2.dollar = 10
var aaa: Int = 100 {
    willSet {
        print("\(aaa)에서 \(newValue)로 변경될 예정입니다.")
    }
    didSet {
        print("\(oldValue)에서 \(aaa)로 변경되었습니다.")
    }
}
aaa = 200

var c = 5
for i in 1..<2 {
    print(i)
}


// MARK: - inherit
class Test {
    var name: String = "Test"
    
    func selfIntroduce() {
        print("\(name)클래스 입니다.")
    }
    class func method() {
        print("Test.. 과연")
    }
}
class TestForTest: Test {
    var more: String = "자식입니다"
    
    override func selfIntroduce() {
        super.selfIntroduce()
        print("그리고 \(super.name)의 자식클래스 \(more)입니다.")
    }
    override class func method() {
        super.method()
        print("호오...")
    }
    static func qwer() {
        
    }
}
class TestForTestForTest: TestForTest {
    override final class func method() {
        super.method()
        print("찐막")
    }
    /*
    override static func qwer() {
        print()
    }
     */
}


var t: Test = Test()
var tt: TestForTest = TestForTest()
t.selfIntroduce()
tt.selfIntroduce()
var ttt: TestForTestForTest = TestForTestForTest()
TestForTestForTest.method()

//MARK: - instance init, deinit
class PersonC {
    var name: String
    var age: Int
    var nickName: String?
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    convenience init(name: String, age: Int, nickName: String) {
        self.init(name: name, age: age)
        self.nickName = nickName
    }
}
var p1: PersonC = PersonC(name: "pio", age: 26, nickName: "piopio")
dump(p1)

//MARK: - 암시적 추출 프로퍼티
class Puppy {
    var name: String
    var guardian: PersonC!
    
    init(name: String) {
        self.name = name
    }
    func goOut() {
        print("\(name)가 보호자 \(guardian.name)에게 꼬리를 흔듭니다.")
    }
}
var happy: Puppy = Puppy(name: "happy")
//happy.goOut()
happy.guardian = p1
happy.goOut()

class PersonD {
    var name: String
    var age: Int
    var nickName: String?
    init?(name: String, age: Int) {
        if (0...120).contains(age) == false {
            return nil
        }
        if name.count == 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}
//var p2: PersonD = PersonD(name: "fanna", age: 22)
let fanna: PersonD? = PersonD(name: "fanna", age: 22)
var joker: PersonD? = PersonD(name: "", age: 23)
var steve: PersonD? = PersonD(name: "steve", age: 123)
dump(fanna)
dump(joker)
dump(steve)
class PersonE {
    var name: String
    var pet: Puppy?
    var child: PersonC
    
    init(name: String, child: PersonC) {
        self.name = name
        self.child = child
    }
    
    deinit {
        if let petName = pet?.name {
            print("\(name)가 \(child.name)에게 \(petName)을 인도합니다.")
        }
    }
}
var donald: PersonE? = PersonE(name: "donald", child: p1)
donald?.pet = happy
donald = nil

func testfunc(_ param: String?) {
    print("param : \(param)")
}
func testfunc() {
    print("NO param")
}
testfunc()
testfunc("ppp")

class Song {
    var title: String?
    var lyrics: String?
    var artist: Artist?
}
class Artist {
    var name: String?
    var age: Int?
}
let song = Song()
//song.artist = Artist()
song.artist?.name = "a"
print(song.artist?.name)

//MARK: - type casting

// - 이건 타입캐스티이 아님
//let someInt: Int = 100
//let someDouble: Double = Double(someInt)

class One {
    var name = "one"
}
class Two: One {
    var prop = "two"
}
class Three: Two {
    var prop2 = "three"
}

let onewithtwo: One = Two() as One
dump(onewithtwo)
let one: One = One()
dump(one)
