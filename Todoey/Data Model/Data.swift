//
//  Data.swift
//  Todoey
//
//  Created by juyeong koh on 2022/10/18.
//

import Foundation
import RealmSwift

// Object는 Data 클래스를 지속할 수 있도록 하는 데 사용할 슈퍼클래스
class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}

