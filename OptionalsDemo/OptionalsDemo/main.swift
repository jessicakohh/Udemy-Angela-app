


struct MyOptional {
    var property = 123
    func method() {
        print("구조체의 메서드")
    }
}

let myOptional: MyOptional?

myOptional = MyOptional()

myOptional?.method()
