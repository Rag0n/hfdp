protocol Duck {
    func quack()
    func fly()
}

// клиент
class MallardDuck: Duck {
    func quack() {
        print("Quack-quack")
    }
    
    func fly() {
        print("I'm flying")
    }
}

protocol Turkey {
    func gobble()
    func fly()
}

// адаптируемый интерфейс
class WildTurkey: Turkey {
    func gobble() {
        print("Gobble-gobble")
    }
    
    func fly() {
        print("I'm flying but only on a short distances :(")
    }
}

// адаптер
class TurkeyAdapter: Duck {
    private let turkey: Turkey
    
    init(turkey: Turkey) {
        self.turkey = turkey
    }
    
    func quack() {
        turkey.gobble()
    }
    
    func fly() {
        for _ in 0..<5 {
            turkey.fly()
        }
    }
}

class DuckAdapter: Turkey {
    private let duck: Duck
    
    init(duck: Duck) {
        self.duck = duck
    }
    
    func gobble() {
        duck.quack()
    }
    
    func fly() {
        duck.fly()
    }
}