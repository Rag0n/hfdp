import Foundation

// интерфейс вместо абстрактного класса
// абстрактный компонент
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

// конкретный декоратор
class Mocha: CondimentDecorator {
    override func description() -> String {
        return super.description() + ", Mocha"
    }
    
    override func cost() -> Double {
        return super.cost() + 0.5
    }
}

var myEspresso:Beverage = Espresso()
var beverageDescription = myEspresso.description()
var beverageCost = myEspresso.cost()

var myDarkRoast:Beverage = DarkRoast()
beverageDescription = myDarkRoast.description()
beverageCost = myDarkRoast.cost()
myDarkRoast = Mocha(beverage: myDarkRoast)
myDarkRoast = Mocha(beverage: myDarkRoast)
myDarkRoast = Mocha(beverage: myDarkRoast)
myDarkRoast = Mocha(beverage: myDarkRoast)
myDarkRoast = Mocha(beverage: myDarkRoast)
beverageDescription = myDarkRoast.description()
beverageCost = myDarkRoast.cost()

