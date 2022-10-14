



class Enemy {
    var health: Int
    var attackStrength: Int
    
    init(health: Int, attackStrength: Int) {
        self.health = health
        self.attackStrength = attackStrength
    }
    
    func move() {
        print("Walk forwards")
    }
    
    func attack() {
        print("Land a hit, dose \(attackStrength) damage")
    }
}


