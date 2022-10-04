import UIKit

// UserDefaults = 사용자 기본값

let defaults = UserDefaults.standard

let dictionaryKey = "myDictionary"


// 볼륨에 대한 지속 데이터를 사용하여 항상 게임이나 앱의 볼륨을 다음으로 설정 가능
defaults.set(0.24, forKey: "Volume")
defaults.set(true, forKey: "MusicOn")
defaults.set("Jessica", forKey: "PlayerName")
defaults.set(Date(), forKey: "AppLastOpenedByUser")

let array = [1,2,3]
defaults.set(array, forKey: "myArray")
let dictionary = ["name" : "Jess"]
defaults.set(dictionary, forKey: dictionaryKey)


let volume = defaults.float(forKey: "Volume")
let appLastOpen = defaults.object(forKey: "AppLastOpenByUser")
let myArray = defaults.array(forKey: "myArray") as! [Int]
let myDictionary = defaults.dictionary(forKey: dictionaryKey)




