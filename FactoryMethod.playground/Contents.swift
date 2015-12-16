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
        switch type {
            case "cheese":
                return NYStyleCheesePizza()
            case "veggie":
                return NYStyleVeggiePizza()
            case "clam":
                return NYStyleClamPizza()
            case "pepperoni":
                return NYStylePepperoniPizza()
        default:
            return NYStyleCheesePizza()
        }
    }
}

// конкретный класс-создатель
class ChikagoPizzaStore: PizzaStore {
    
    func createPizza(type: String) -> Pizza {
        switch type {
        case "cheese":
            return ChikagoStyleCheesePizza()
        case "veggie":
            return ChikagoStyleVeggiePizza()
        case "clam":
            return ChikagoStyleClamPizza()
        case "pepperoni":
            return ChikagoStylePepperoniPizza()
        default:
            return ChikagoStyleCheesePizza()
        }
    }
}

// абстрактный продукт
protocol Pizza {
    var name: String { get }
    var dough: String { get }
    var sauce: String { get }
    var toppings: [String] { get }
    
    func prepare()
    
    func bake()
    
    func cut()
    
    func box()
}

// добавляем реализацию по умолчанию
extension Pizza {
    
    func prepare() {
        print("Preparing \(name)")
        print("Tossing dough...")
        print("Adding sauce")
        print("Adding toppings \(toppings)")
    }
    
    func bake() {
        print("Bake for 25 minutes at 350")
    }
    
    func cut() {
        print("Cutting the pizza into diagonal slices")
    }
    
    func box() {
        print("Place pizza in the official PizzaStore box")
    }
}

// конкретные продукты
class NYStyleCheesePizza: Pizza {
    let name = "Ny style Sauce and Cheese Pizza"
    let dough = "Thin Crust Dough"
    let sauce = "Marinara Sauce"
    let toppings = ["Grated Reggiano Cheese"]
}

class NYStyleVeggiePizza: Pizza {
    let name = "Ny style Sauce and Veggie Pizza"
    let dough = "Thin Crust Dough"
    let sauce = "Marinara Sauce"
    let toppings = ["Veggie"]
}

class NYStyleClamPizza: Pizza {
    let name = "Ny style Sauce and Clam Pizza"
    let dough = "Thin Crust Dough"
    let sauce = "Marinara Sauce"
    let toppings = ["Clam"]
}

class NYStylePepperoniPizza: Pizza {
    let name = "Ny style Sauce and Pepperoni Pizza"
    let dough = "Thin Crust Dough"
    let sauce = "Marinara Sauce"
    let toppings = ["Pepperoni"]
}

class ChikagoStyleCheesePizza: Pizza {
    let name = "Chikago style Deep Dish Cheese Pizza"
    let dough = "Extra Thick Crust Dough"
    let sauce = "Plum Tomato Sauce"
    let toppings = ["Shredded Mozarella Cheese"]
    
    func cut() {
        print("Cutting pizza into square slices")
    }
}

class ChikagoStyleVeggiePizza: Pizza {
    let name = "Chikago style Deep Dish Veggie Pizza"
    let dough = "Extra Thick Crust Dough"
    let sauce = "Plum Tomato Sauce"
    let toppings = ["Veggie"]
    
    func cut() {
        print("Cutting pizza into square slices")
    }
}

class ChikagoStyleClamPizza: Pizza {
    let name = "Chikago style Deep Dish Clam Pizza"
    let dough = "Extra Thick Crust Dough"
    let sauce = "Plum Tomato Sauce"
    let toppings = ["Clam"]
    
    func cut() {
        print("Cutting pizza into square slices")
    }
}

class ChikagoStylePepperoniPizza: Pizza {
    let name = "Chikago style Deep Dish Pepperoni Pizza"
    let dough = "Extra Thick Crust Dough"
    let sauce = "Plum Tomato Sauce"
    let toppings = ["Pepperoni"]
    
    func cut() {
        print("Cutting pizza into square slices")
    }
}

let nyStore = NYPizzaStore()
let chikagoStore = ChikagoPizzaStore()
let NYPizza = nyStore.orderPizza("cheese")
print("\n")
let ChikagoPizza = chikagoStore.orderPizza("cheese")
print(NYPizza.name)
print(ChikagoPizza.name)