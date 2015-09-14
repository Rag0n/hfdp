import Foundation

// abstract products
protocol Dough {}
protocol Sauce {}
protocol Cheese {}
protocol Veggies {}
protocol Pepperoni {}
protocol Clams {}

// abstract factory
protocol PizzaIngredientFactory {
    func createDough() -> Dough
    func createSauce() -> Sauce
    func createCheese() -> Cheese
    func createVeggies() -> [Veggies]
    func createPepperoni() -> Pepperoni
    func createClam() -> Clams
}

// concrete factory
class NYPizzaIngredientFactory: PizzaIngredientFactory {
    func createDough() -> Dough {
        return ThinCrustDough()
    }
    
    func createSauce() -> Sauce {
        return MarinaraSauce()
    }
    
    func createCheese() -> Cheese {
        return ReggianoCheese()
    }
    
    func createVeggies() -> [Veggies] {
        var veggies: [Veggies] = [Garlic(), Onion(), Mushroom(), RedPepper()]
        return veggies
    }
    
    func createPepperoni() -> Pepperoni {
        return SlicedPepperoni()
    }
    
    func createClam() -> Clams {
        return FreshClams()
    }
}


// concrete factory
class ChikagoPizzaIngredientFactory: PizzaIngredientFactory {
    func createDough() -> Dough {
        return ThinCrustDough()
    }
    
    func createSauce() -> Sauce {
        return MarinaraSauce()
    }
    
    func createCheese() -> Cheese {
        return ReggianoCheese()
    }
    
    func createVeggies() -> [Veggies] {
        var veggies: [Veggies] = [Garlic(), Onion(), Mushroom(), RedPepper()]
        return veggies
    }
    
    func createPepperoni() -> Pepperoni {
        return SlicedPepperoni()
    }
    
    func createClam() -> Clams {
        return FreshClams()
    }
}

// concrete products
class Garlic: Veggies {}
class Onion: Veggies {}
class Mushroom: Veggies {}
class RedPepper: Veggies {}
class ThinCrustDough: Dough {}
class MarinaraSauce: Sauce {}
class ReggianoCheese: Cheese {}
class SlicedPepperoni: Pepperoni {}
class FreshClams: Clams {}

// abstract product
class Pizza {
    var name: String?
    var dough: Dough?
    var sauce: Sauce?
    var veggies: [Veggies]?
    var cheese: Cheese?
    var pepperoni: Pepperoni?
    var clam: Clams?
    
    // abstract method
    func prepare() {
        println("Preparing \(name)")
        println("Tossing dough...")
        println("Adding sauce...")
    }
    
    func bake() {
        println("Bake for 25 minutes at 350")
    }
    
    func cut() {
        println("Cutting the pizza into diagonal slices")
    }
    
    func box() {
        println("Place pizza in official PizzaStore box")
    }
}

// concrete pclient
class CheesePizza: Pizza {
    var ingredientFactory: PizzaIngredientFactory
    
    init(ingredientFactory: PizzaIngredientFactory) {
        self.ingredientFactory = ingredientFactory
    }
    
    override func prepare() {
        println("Preparing \(name)")
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
    }
}

// concrete product, but different ingredients
class ClamPizza: Pizza {
    var ingredientFactory: PizzaIngredientFactory
    
    init(ingredientFactory: PizzaIngredientFactory) {
        self.ingredientFactory = ingredientFactory
    }
    
    override func prepare() {
        println("Preparing \(name)")
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
        clam = ingredientFactory.createClam()
    }
}



protocol PizzaStoreInterface {
    func orderPizza(type: String) -> Pizza
    func createPizza(type: String) -> Pizza
}

// abstract type(Client)
class PizzaStore: PizzaStoreInterface {
    final func orderPizza(type: String) -> Pizza {
        let pizza = createPizza(type)

        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        
        return pizza
    }
    
    // abstract fabric method
    func createPizza(type: String) -> Pizza {
        return Pizza()
    }
}

// Concrete client
class NYStylePizzaStore: PizzaStore {
    // fabric method
    override func createPizza(type: String) -> Pizza {
        var pizza: Pizza
        var ingredientFactory: PizzaIngredientFactory = NYPizzaIngredientFactory()
        
        switch type {
            case "cheese": pizza = CheesePizza(ingredientFactory: ingredientFactory)
            case "pepperoni": pizza = ClamPizza(ingredientFactory: ingredientFactory)
            default: pizza = Pizza()
        }
        return pizza
    }
}

// Concrete client
class ChikagoStylePizzaStore: PizzaStore {
    // fabric method
    override func createPizza(type: String) -> Pizza {
        var pizza: Pizza
        var ingredientFactory: PizzaIngredientFactory = ChikagoPizzaIngredientFactory()
        
        switch type {
        case "cheese": pizza = CheesePizza(ingredientFactory: ingredientFactory)
        case "pepperoni": pizza = ClamPizza(ingredientFactory: ingredientFactory)
        default: pizza = Pizza()
        }
        return pizza
    }
}


var nyStore = NYStylePizzaStore()
var chikagoStore = ChikagoStylePizzaStore()
var pizza: Pizza = nyStore.orderPizza("cheese")
pizza = chikagoStore.orderPizza("cheese")

