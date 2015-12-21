protocol CaffeineBeverage {
    // шаблонный метод
    func prepareRecipe()
    
    // примитивные операции
    func boilWater()
    func brew()
    func pourInCup()
    func addCondiments()
}

extension CaffeineBeverage {
    // шаблонный метод
    func prepareRecipe() {
        boilWater()
        brew()
        pourInCup()
        addCondiments()
    }
    
    // реализуем общие операции шаблонного метода
    // специфичные делегируем конкретным классам
    func boilWater() {
        print("Boiling water")
    }
    
    func pourInCup() {
        print("Pouring into cup")
    }
}

class Coffee: CaffeineBeverage {
    // специфичные операции
    func brew() {
        print("Dripping coffee")
    }
    
    func addCondiments() {
        print("Adding sugar and milk")
    }
}

class Tea: CaffeineBeverage {
    // специфичные операции
    func brew() {
        print("Stepping the tea")
    }

    func addCondiments() {
        print("Adding lemon")
    }
}

let myTea = Tea()
myTea.prepareRecipe()
let myCoffee = Coffee()
myCoffee.prepareRecipe()