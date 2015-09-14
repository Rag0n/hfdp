// Паттерн проектирования СТРАТЕГИЯ

import Foundation

// Абстрактный тип(в данном случае интерфейс, а не абстрактный класс)
protocol FlyBehavior {
    func fly()
}

protocol QuackBehavior {
    func quack()
}

// Конкретные реализации
class FlyWithWings: FlyBehavior {
    func fly() {
        println("I'm flying with wings")
    }
}

class FlyNoWay: FlyBehavior {
    func fly() {
        println("I don't have wings and therefore I cant fly :(")
    }
}

class Quack: QuackBehavior {
    func quack() {
        println("Quack-quack")
    }
}

class Squeak: QuackBehavior {
    func quack() {
        println("Squeak-squeak")
    }
}

// Класс, имеющий постоянные аспекты и делегирующий переменные
// Связь между Duck и FlyBehavior/QuackBehavior - это композиция, а не наследование
class Duck {
    // делегация
    var flyBehavior: FlyBehavior?
    var quackBehavior: QuackBehavior?
    
    func performQuack() {
        quackBehavior?.quack()
    }
    
    func performFly() {
        flyBehavior?.fly()
    }
    
    func display() {
        println("I'm a duck")
    }
}

class MallardDuck: Duck {
    override func display() {
        println("I'm a mallard duck")
    }
}

//var myDuck = Duck()
//myDuck.display()
//myDuck = MallardDuck()
//myDuck.display()
//myDuck.performFly()
//myDuck.flyBehavior = FlyWithWings()
//myDuck.performFly()

