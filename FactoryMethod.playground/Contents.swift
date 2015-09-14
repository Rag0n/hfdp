import Foundation

// product
class Pizza {
    var name: String?
    var dough: String?
    var sauce: String?
    var toppings = [String]()
    
    func prepare() {
        println("Preparing \(name)")
        println("Tossing dough...")
        println("Adding sauce...")
        println("Adding toppings \(toppings)")
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

// concrete product
class NYCheesePizza: Pizza {
    override init() {
        super.init()
        name = "NY Style Sauce and Cheese pizza"
        dough = "Thin Crust Dough"
        sauce = "Marinara Sauce"
        toppings.append("Grated Reggiano Cheese")
    }
}

// concrete product
class ChikagoCheesePizza: Pizza {
    override init() {
        super.init()
        name = "Chikago Style Deep Dish Cheese pizza"
        dough = "Extra Thick Crust Dough"
        sauce = "Plum Tomato Sauce"
        toppings.append("Shredded Mozzarella Cheese")
    }
}

// concrete product
class NYPepperoniPizza: Pizza {
    override init() {
        super.init()
        name = "Pepperoni pizza"
    }
}

// concrete product
class ChikagoPepperoniPizza: Pizza {
    override init() {
        super.init()
        name = "Pepperoni pizza"
    }
    
    override func cut() {
        println("Cutting the pizza into square slices")
    }
}


// abstact type(interface)
protocol PizzaStoreInterface {
    func orderPizza(type: String) -> Pizza
    func createPizza(type: String) -> Pizza
}

// abstract type(Creator)
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

// Concrete creator
class NYStylePizzaStore: PizzaStore {
    // fabric method
    override func createPizza(type: String) -> Pizza {
        var pizza: Pizza
        switch type {
        case "cheese": pizza = NYCheesePizza()
        case "pepperoni": pizza = NYPepperoniPizza()
        default: pizza = Pizza()
        }
        return pizza
    }
}

// Concrete creator
class ChikagoStylePizzaStore: PizzaStore {
    // fabric method
    override func createPizza(type: String) -> Pizza {
        var pizza: Pizza
        switch type {
        case "cheese": pizza = ChikagoCheesePizza()
        case "pepperoni": pizza = ChikagoPepperoniPizza()
        default: pizza = Pizza()
        }
        return pizza
    }
}


var nyStore = NYStylePizzaStore()
var chikagoStore = ChikagoStylePizzaStore()
var pizza: Pizza = nyStore.orderPizza("cheese")
pizza = chikagoStore.orderPizza("cheese")

