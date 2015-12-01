import Foundation

// в качестве супертипа - протокол(интерфейс)
protocol FlyBehavior {
    func fly()
}

// конкретные классы поведения, описываемые супертипом
class FlyWithWings: FlyBehavior {
    func fly() {
        print("Я летаю с помощью крыльев")
    }
}

class FlyNoWay: FlyBehavior {
    func fly() {
        print("Я не летаю")
    }
}

// в качестве супертипа - протокол(интерфейс)
protocol QuackBehavior {
    func quack()
}

// конкретные классы поведения, описываемые супертипом
class Quack: QuackBehavior {
    func quack() {
        print("Я крякаю: quack-quack")
    }
}

class QuackMute: QuackBehavior {
    func quack() {
        print("Я не крякаю :(")
    }
}

class Squeak: QuackBehavior {
    func quack() {
        print("Я пищу: squeak-squeak")
    }
}


class Duck {
    // Клиент Duck связан с абстракцией, а не с конкретными реализациями
    private var flyBehavior: FlyBehavior
    private var quackBehavior: QuackBehavior
    
    required convenience init() {
        self.init(flyBehavior: FlyNoWay(), quackBehavior: QuackMute())
    }
    
    private init(flyBehavior: FlyBehavior, quackBehavior: QuackBehavior) {
        self.flyBehavior = flyBehavior
        self.quackBehavior = quackBehavior
    }
    
    func display() {
        print("Я утка")
    }
    
    func performFly() {
        // делегируем поведение
        flyBehavior.fly()
    }
    
    func performQuack() {
        // делегируем поведение
        quackBehavior.quack()
    }
    
    func setFlyBehavior(flyBehavior: FlyBehavior) {
        self.flyBehavior = flyBehavior
    }
    
    func setQuackBehavior(quackBehavior: QuackBehavior) {
        self.quackBehavior = quackBehavior
    }
}


class MallardDuck: Duck {
    required init() {
        super.init(flyBehavior: FlyWithWings(), quackBehavior: Quack())
    }
    
    override func display() {
        print("Я дикая(mallard) утка")
    }
}

class ModelDuck: Duck {
    required init() {
        super.init(flyBehavior: FlyNoWay(), quackBehavior: Quack())
    }
    
    override func display() {
        print("Я утка-приманка(model)")
    }
}


// Тестирование
var duck: Duck = Duck()
duck.display()
duck.performFly()
duck.performQuack()

duck = MallardDuck()
duck.display()
duck.performFly()
duck.performQuack()
