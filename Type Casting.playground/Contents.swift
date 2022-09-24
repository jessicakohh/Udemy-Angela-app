import UIKit



class Animal {
    var name: String
    
    init(n: String) {
        name = n
    }
}

class Human: Animal {
    func code() {
        print("코딩하기")
    }
}


class Fish: Animal {
    func breatheUnderWater() {
        print("물 밑에서 숨쉬기")
    }
}


let jess = Human(n: "Jess Ko")
let felix = Human(n: "Felix Lee")
let nemo = Fish(n: "Nemo")

let neighbours = [jess, felix, nemo]



if felix is Human {
    print("첫 번째 이웃은 사람이다")
}

// is
//let cell = UITableViewCell()
//if cell is UITableViewCell {
//    print("타입 매치")
//}


func findNemo(form animals: [Animal]) {
    for animal in animals {
        if animal is Fish {
            print(animal.name)
            let fish = animal as! Fish
            fish.breatheUnderWater()
        }
    }
}
findNemo(form: neighbours)


if let fish = neighbours[1] as? Fish {
    fish.breatheUnderWater()
} else {
    print("캐스팅 실패")
}


