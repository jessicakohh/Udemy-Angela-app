import UIKit

//let defaults = UserDefaults.standard
//let sharedURLSession = URLSession.shared

//class Car {
//    var colour = "red"
//
//}
//
//let myCar = Car()
//myCar.colour = "Blue"
//
//let yourCar = Car()
//print(yourCar.colour)



// ✨ Singleton
class Car {
    var colour = "red"
    
    static let singletonCar = Car()
}

let myCar = Car.singletonCar
myCar.colour = "Blue"

let yourCar = Car.singletonCar
print(yourCar.colour)

class A {
    init() {
        Car.singletonCar.colour = "Brown"
    }
}

class B {
    init() {
        print(Car.singletonCar.colour)
    }
}

let a = A()
let b = B()
