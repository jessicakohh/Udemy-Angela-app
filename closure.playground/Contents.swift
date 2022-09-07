import UIKit


// MARK: - 예제1

func calculator (n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}


let result = calculator(n1: 2, n2: 3) { $0 * $1 }

print(result)



// MARK: - 예제2

let array = [6,2,3,9,4,1]

//func addOne (n1: Int) -> Int {
//    return n1 + 1
//}

array.map{ $0 + 1 }
print(array.map{ $0 + 1 })
