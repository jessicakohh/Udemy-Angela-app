import UIKit



struct MyStructure {
    let instanceProperty = "ABC"
    static let typeProperty = "123"
    
    func instanceMethod() {
        
    }
    
    func typeMethod() {
        
    }
    
}



let myStructure = MyStructure()
print(myStructure.instanceProperty)


MyStructure.typeProperty
myStructure.instanceProperty

// Type Method : 메서드라서 메모리공간 할당 안되고
// 개체를 초기화하지 않고도 엑세스, 호출 가능하다
