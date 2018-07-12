//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//map : 배열안의 값들을 매핑해서 새로운 배열을 반환(클로져 사용)
let values = [1,2,3,4,5]
let valueString = values.map({ (v: Int ) -> (String) in
return "\(v)"})

print(valueString)

let evenValues = values.filter(
{
    (v: Int) -> (Bool) in if v % 2 == 0 {return true }
    return false
})

print(evenValues)

// .filter : 클로져 안의 논리로직과 일치하는 결과만 필터하여 새로운 배열 반환
let valuesString = ["1","2","3","4"]
let valuesFilterString = ["1","2"]

let evenStrings = valuesString.filter(
{
    (v: String) -> (Bool) in
    for obj  in valuesFilterString {
        if v == obj {
            return true
        }
    }
    return false
})

print(evenStrings)

//dic
let dict: [String: Int] = [ "a": 1, "b": 2 ]
let dicFilter = dict.filter { (key, value) in
//    return (key == "a")
    return (value == 2)
}
print(dicFilter)


// reduce : combine 이라는 표현이 더 잘 어울리는데, 하는 일은 배열의 모든 아이템을 꺼내서 하나로 합치는 형태
//Array.reduce(initial: U, combine:(U,T) -> U)

let sumValues = values.reduce(0, +)
let sumCodes = values.map({(v:Int) -> (String) in return "\(v)"}) .reduce("sumCodes=", +)
let sumCodesFilterd = values.filter({(v:Int)->(Bool) in

    if v == 1 {return true}
    return false
}).map({(v:Int) -> (String) in return "\(v)"}) .reduce("sumCodesFilterd=", +)
//let sumCodes = valueString.reduce("sumCodes=", +)

print(sumValues)
print(sumCodes)
print(sumCodesFilterd)

//flapMap
let collections = [[5,2,7],[4,8],[9,1,3]]
let flat = collections.flatMap{ $0 }
print(flat)

let people: [[String?]?] = [["Tim","choi"],nil,[""],["good",""]]
let flatpeople = people.flatMap{ $0 }
print(flatpeople)

let onlyEven = collections.flatMap {
    intArray in intArray.filter {$0%2 == 0}
}
print(onlyEven)

let onlyEven2 = collections.flatMap{
    $0.filter { $0 == 1 }
}

print(onlyEven2)

//let sums = collections.flatMap { $0.reduce(0, +) }
let sums = collections.map { $0.reduce(0, +) }
print(sums)

let marks = [4,5,8,2,9,7]
let totalPass = marks.filter{$0 >= 7}.reduce(0, +)
print(totalPass)

let numbers = [20,17,35,4,12]
let evenSquares = numbers.map{$0 * $0 }.filter{$0 % 2 == 0}
print(evenSquares)




