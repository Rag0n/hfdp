//: Playground - noun: a place where people can play

import Foundation

class Pizza {
    var name = "Pizza";
    
    func prepare() {
        
    }
    
    func bake() {
        
    }
    
    func cut() {
        
    }
    
    func box() {
        
    }
}

class CheesePizza: Pizza {
    override init() {
        super.init()
        name = "Cheese pizza"
    }
}

class PepperoniPizza: Pizza {
    override init() {
        super.init()
        name = "Pepperoni pizza"
    }
}

// Простая фабрика, не паттерн, а идиома
class SimplePizzaFactory {
    func createPizza(withType: String) -> Pizza {
        var pizza: Pizza
        switch withType {
            case "cheese": pizza = CheesePizza()
            case "pepperoni": pizza = PepperoniPizza()
            default: pizza = Pizza()
        }
        return pizza
    }
}

class PizzaStore {
    var factory: SimplePizzaFactory
    
    init(factory: SimplePizzaFactory) {
        self.factory = factory
    }
    
    func orderPizza(type: String) -> Pizza {
        var pizza = factory.createPizza(type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        
        return pizza
    }
}
