import UIKit

//#Optional
var str = "Hello, playground"
let optionalStr: String? = nil
var optionalStr2: String! = nil
print(optionalStr)
//print(optionalStr2)

var myName: String? = "hkp"
var friend: String? = nil
if let me = myName, let you = friend {
    print("\(me) and \(you)")
}
else {
    print("error")
}
friend = "somebody"
if let me = myName, let you = friend {
    print("\(me) and \(you)")
}
else {
    print("error")
}

//#구조체
struct Sample {
    var mutableProperty: Int = 100
    let immutableProperty: Int = 100
    static var typeProperty: Int = 100
    
    func instanceMethod() {
        print("instance method")
    }
    
    static func typeMethod() {
        print("type method")
    }
}
var samp: Sample = Sample()
samp.mutableProperty = 200
//samp.immutableProperty = 200
print("\(samp.mutableProperty) \(samp.immutableProperty)")
let samp2: Sample = Sample()
//samp2.mutableProperty = 200
//samp.typeProperty //타입 프로퍼티, 메소드는 인스턴스에서 접근 불가
Sample.typeMethod()
print(Sample.typeProperty)

struct Student {
    var name: String = "unknown"
    var `class`: String = "Swift"
    
    static func selfIntroduce() {
        print("학생입니다")
    }
    
    func selfIntroduce() {
        print("저는 \(self.class)반 \(name)입니다")
    }
}
var hkp: Student = Student()
hkp.name = "kyungpyo"
hkp.selfIntroduce()
let someone: Student = Student()
//someone.name = "asdfasdf"
someone.selfIntroduce()

//#클래스
class Sample2 {
    var mutableProperty: Int = 100
    let immutableProperty: Int = 100
    static var typeProperty: Int = 100
    
    func instanceMethod() {
        print("instance method")
    }
    //재정의 불가 타입 메서드
    static func typeMethod() {
        print("type method - static")
    }
    //재정의 가능 타입 메서드
    class func classMethod() {
        print("type method - class")
    }
}

var mutableReference: Sample2 = Sample2()
mutableReference.mutableProperty = 200
let immutableReference: Sample2 = Sample2()
immutableReference.mutableProperty = 200 // 상수 인스턴스 이지만 변수 프로퍼티 변경 가능,,,,

//열거형
enum Weekday {
    case mon
    case tue
    case wed
    case thu, fri, sat, sun
}
var day:Weekday = Weekday.mon
day = .tue
print(day)
day = .fri
switch day {
case .mon, .tue, .wed, .thu:
    print("평일입니다")
case Weekday.fri:
    print("불금입니다")
case .sat, .sun:
    print("주말입니다")
}
//rawValue
enum Fruit: Int {
    case apple = 0
    case grape = 1
    case peach //자동으로 1씩 증가
    //case mango = 0
}
print("Fruit.peach.rawValue = \(Fruit.peach.rawValue)")
enum School: String {
    case elementary = "초등"
    case middle = "중등"
    case high = "고등"
    case university
}
print("School.middle.rawValue = \(School.middle.rawValue)")
print("School.university.rawValue = \(School.university.rawValue)")

let apple: Fruit? = Fruit(rawValue: 0)
if let orange: Fruit? = Fruit(rawValue: 5) {
    print("rawValue 5에 해당하는 케이스는 \(orange)입니다")
} else {
    print("rawValue 5에 해당하는 케이스가 없습니다")
}
print(apple!)
enum Month {
    case jan, feb, mar
    case apr, may, jun
    case jul, aug, sep
    case oct, nov, dec
    func printMessage() {
        switch self {
        case .mar, .apr, .may:
            print("봄입니다")
        case .jun, .jul, .aug:
            print("여름입니다")
        case .sep, .oct, .nov:
            print("가을입니다")
        case .dec, .jan, .feb:
            print("겨울입니다")
        }
    }
}
Month.mar.printMessage()


