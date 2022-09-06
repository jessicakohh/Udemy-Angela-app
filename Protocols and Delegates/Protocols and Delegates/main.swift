


protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?
    
    func assessSituation() {
        print("무슨 일이 있었는지 알려줄 수 있나요?")
    }
    
    func medicalEmergency() {
        delegate?.performCPR()
    }
}



struct Paramedic: AdvancedLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("초당 30번의 흉부압박")
    }

}

class Doctor: AdvancedLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        // 호출기를 들고 교대될 때 내가 갈 것이라고 말하는 것
        handler.delegate = self
    }
    
    func performCPR() {
        print("의사의 초당 30번의 흉부압박")
    }
    
    func useStethescope() {
        print("심장소리 듣기")
    }
}


class Surgeon: Doctor {
    override func performCPR() {
        super.performCPR()
        print("CPR하는동안 노래부르기")
    }
    
    func useElectricDrill() {
        print("윙윙")
    }
}



let jessica = EmergencyCallHandler()
let felix = Paramedic(handler: jessica)
let chris = Surgeon(handler: jessica)

jessica.assessSituation()
jessica.medicalEmergency()
