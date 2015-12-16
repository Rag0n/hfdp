// абстрактные продукты-ингредиенты
protocol Dough {}
protocol Sauce {}
protocol Cheese {}
protocol Veggies {}
protocol Pepperoni {}
protocol Clams {}

// абстрактная фабрика
protocol PizzaIngredientFactory {
    func createDough() -> Dough
    func createSauce() -> Sauce
    func createCheese() -> Cheese
    func createVeggies() -> [Veggies]
    func createPepperoni() -> Pepperoni
    func createClam() -> Clams
}

// конкретная фабрика
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
        let veggies: [Veggies] = [Garlic(), Onion(), Mushroom(), RedPepper()]
        return veggies
    }
    
    func createPepperoni() -> Pepperoni {
        return SlicedPepperoni()
    }
    
    func createClam() -> Clams {
        return FreshClams()
    }
}


// конкретная фабрика
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
        let veggies: [Veggies] = [Garlic(), Onion(), Mushroom(), RedPepper()]
        return veggies
    }
    
    func createPepperoni() -> Pepperoni {
        return SlicedPepperoni()
    }
    
    func createClam() -> Clams {
        return FreshClams()
    }
}

// конкретные продукты-ингредиенты
class Garlic: Veggies {}
class Onion: Veggies {}
class Mushroom: Veggies {}
class RedPepper: Veggies {}
class ThinCrustDough: Dough {}
class MarinaraSauce: Sauce {}
class ReggianoCheese: Cheese {}
class SlicedPepperoni: Pepperoni {}
class FreshClams: Clams {}


// абстрактные продукт
protocol Pizza {
    var name: String! { get set }
    var dough: Dough! { get }
    var sauce: Sauce! { get }
    var veggies: [Veggies]? { get }
    var cheese: Cheese? { get }
    var pepperoni: Pepperoni? { get }
    var clam: Clams? { get }
    
    // абстрактный метод
    func prepare()
    
    func bake()
    func cut()
    func box()
}

extension Pizza {
    
    func bake() {
        print("Bake for 25 minutes at 350")
    }
    
    func cut() {
        print("Cutting the pizza into diagonal slices")
    }
    
    func box() {
        print("Place pizza in official PizzaStore box")
    }
}

// конкретный продукт
class CheesePizza: Pizza {
    var name: String!
    var dough: Dough!
    var sauce: Sauce!
    var veggies: [Veggies]?
    var cheese: Cheese?
    var pepperoni: Pepperoni?
    var clam: Clams?
    
    var ingredientFactory: PizzaIngredientFactory
    
    init(ingredientFactory: PizzaIngredientFactory) {
        self.ingredientFactory = ingredientFactory
    }
    
    func prepare() {
        print("Preparing \(name)")
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
    }
}

// конкретный продукт с другими ингредиентами
class ClamPizza: Pizza {
    var name: String!
    var dough: Dough!
    var sauce: Sauce!
    var veggies: [Veggies]?
    var cheese: Cheese?
    var pepperoni: Pepperoni?
    var clam: Clams?
    
    var ingredientFactory: PizzaIngredientFactory
    
    init(ingredientFactory: PizzaIngredientFactory) {
        self.ingredientFactory = ingredientFactory
    }
    
    func prepare() {
        print("Preparing \(name)")
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
        // У Нью-Йоркской фабрики мидии будут свежими, у Чикагской - мороженными
        // но наши классы от этого не зависят - данные аспекты определяются фабрикой
        clam = ingredientFactory.createClam()
    }
}


// абстрактный класс создатель
protocol PizzaStore {
    func orderPizza(type: String) -> Pizza
    // фабричный метод
    func createPizza(type: String) -> Pizza
}

extension PizzaStore {
    func orderPizza(type: String) -> Pizza {
        // для создание пиццы используем фабричный метод
        let pizza = createPizza(type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        
        return pizza
    }
}

// конкретный класс-создатель
class NYPizzaStore: PizzaStore {
    
    func createPizza(type: String) -> Pizza {
        let ingredientFactory = NYPizzaIngredientFactory()
        let newPizza: Pizza
        
        switch type {
        case "cheese":
            newPizza = CheesePizza(ingredientFactory: ingredientFactory)
            newPizza.name = "New York Style Cheese Pizza"
        case "clam":
            newPizza = ClamPizza(ingredientFactory: ingredientFactory)
            newPizza.name = "New York Style Clam Pizza"
        default:
            newPizza = CheesePizza(ingredientFactory: ingredientFactory)
            newPizza.name = "New York Style Cheese Pizza"
        }
        
        return newPizza
    }
}


// конкретный класс-создатель
class ChikagoPizzaStore: PizzaStore {
    // fabric method
    func createPizza(type: String) -> Pizza {
        let ingredientFactory: PizzaIngredientFactory = ChikagoPizzaIngredientFactory()
        let newPizza: Pizza
        
        switch type {
        case "cheese":
            newPizza = CheesePizza(ingredientFactory: ingredientFactory)
            newPizza.name = "Chikago Style Cheese Pizza"
        case "clam":
            newPizza = ClamPizza(ingredientFactory: ingredientFactory)
            newPizza.name = "Chikago Style Clam Pizza"
        default:
            newPizza = CheesePizza(ingredientFactory: ingredientFactory)
            newPizza.name = "Chikago Style Cheese Pizza"
        }
        return newPizza
    }
}


let nyStore = NYPizzaStore()
let chikagoStore = ChikagoPizzaStore()
var pizza: Pizza
pizza = nyStore.orderPizza("cheese")
print(pizza.name)
print("\n")
pizza = chikagoStore.orderPizza("cheese")
print(pizza.name)

