import Foundation

// абстрактный компонент, общий интерфейс
protocol Beverage {
    func cost() -> Double
    func description() -> String
}

// абстрактный декоратор
class CondimentDecorator: Beverage {
    private var decoratedBeverage: Beverage
    
    init(beverage: Beverage) {
        decoratedBeverage = beverage
    }
    
    func description() -> String {
        return decoratedBeverage.description()
    }
    
    func cost() -> Double {
        return decoratedBeverage.cost()
    }
}

// конкретный компонент
class Espresso: Beverage {
    func description() -> String {
        return "Espresso"
    }
    
    func cost() -> Double {
        return 1.99
    }
}

// конкретный компонент
class DarkRoast: Beverage {
    func description() -> String {
        return "Dark Roast"
    }
    
    func cost() -> Double {
        return 2.99
    }
}

// конкретное дополнение
class Mocha: CondimentDecorator {
    override func description() -> String {
        return super.description() + ", Mocha"
    }
    
    override func cost() -> Double {
        return super.cost() + 0.5
    }
}

// конкретное дополнение
class Whip: CondimentDecorator {
    override func description() -> String {
        return super.description() + ", Whip"
    }
    
    override func cost() -> Double {
        return super.cost() + 0.2
    }
}


var myEspresso:Beverage = Espresso()
print(myEspresso.description())
print(myEspresso.cost())

var myDarkRoast:Beverage = DarkRoast()
print(myDarkRoast.description())
print(myDarkRoast.cost())

myDarkRoast = Mocha(beverage: myDarkRoast)
myDarkRoast = Mocha(beverage: myDarkRoast)
myDarkRoast = Whip(beverage: myDarkRoast)
print(myDarkRoast.description())
print(myDarkRoast.cost())

