//: Playground - noun: a place where people can play

import Foundation

protocol Subject: class {
    func registerObserver(observer: Observer)
    func removeObserver(observer: Observer)
    func notifyObservers()
}

// Все наблюдатели реализуют данный протокол
// Реализовывать данный протокол могут только классы
// Потому что при удалении идет сравнение по ссылке, а не значению
protocol Observer: class {
    func update(temperature temperature: Double, humidity: Double, pressure: Double)
}

// UI классы должны реализовывать данный протокол
protocol DisplayElement {
    func display()
}

// Класс субъекта, обладает 3 состояними(температура, влажность, давление) и уведомляет наблюдаетелей об изменениях
class WeatherData: Subject {
    private var temperature: Double!
    private var humidity: Double!
    private var pressure: Double!
    private var observers = [Observer]()
    
    func registerObserver(observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(observer: Observer) {
        observers = observers.filter { $0 !== observer }
    }
    
    func notifyObservers() {
        for observer in observers {
            // активная доставка
            observer.update(temperature: temperature, humidity: humidity, pressure: pressure)
        }
    }
    
    // вызов этой функции происходит извне при изменении данных(состояния)
    func measurementsChanged() {
        notifyObservers()
    }
    
    // тестовый метод
    func setMeasurements(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        measurementsChanged()
    }
}

class CurrentConditionsDisplay: Observer, DisplayElement {
    private var temperature: Double!
    private var pressure: Double!
    // требуется чтобы удалить себя из списка наблюдателей
    private weak var weatherData: Subject!
    
    init(weatherData: Subject) {
        self.weatherData = weatherData
        self.weatherData.registerObserver(self)
    }
    
    // humidity нас не интересует, но доставка активная - принимаем все параметры
    func update(temperature temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.pressure = pressure
        display()
    }
    
    // зависимая функциональность в данном случае это
    // представление температуры и давления в UI
    func display() {
        print("Current Temperature = \(temperature), current pressure = \(pressure)")
    }
}


class ForecastConditions: Observer, DisplayElement {
    private var temperature:Double!
    private var pressure:Double!
    private var humidity:Double!
    private var weatherData:Subject!
    
    init(weatherData:Subject) {
        self.weatherData = weatherData
        self.weatherData.registerObserver(self)
    }
    
    func update(temperature temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        display()
    }
    
    func display() {
        print("Forecast temperature is \(temperature), Forecast pressure is \(pressure)\n")
    }
}


let weatherData = WeatherData()
let currentConditionDisplay = CurrentConditionsDisplay(weatherData: weatherData)
let forecastConditionDisplay = ForecastConditions(weatherData: weatherData)
weatherData.setMeasurements(5, humidity: 5, pressure: 8)
weatherData.setMeasurements(10, humidity: 11, pressure: 12)