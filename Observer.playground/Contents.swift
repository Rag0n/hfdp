import Foundation

// Субьект, который оповещает наблюдателей
protocol Subject {
    func registerObserver(observer:Observer)
    func removeObserver(observer:Observer)
    func notifyObservers()
}

// Наблюдатели реализуют метод, которые вызывается при изменение состояния субъекта
protocol Observer: class {
    func update(temperature:Double?, humidity:Double?, pressure:Double?)
}


class WeatherData: Subject {
    private var observersList = [Observer]()
    private var temperature:Double?
    private var humidity:Double?
    private var pressure:Double?
    
    func registerObserver(observer: Observer) {
        observersList.append(observer)
    }
    
    func removeObserver(observer: Observer) {
        observersList = observersList.filter { $0 !== observer }
    }
    
    func notifyObservers() {
        for observer in observersList {
            observer.update(temperature, humidity: humidity, pressure: pressure)
        }
    }
    
    func measurementsChanged() {
        notifyObservers()
    }
    
    func setMeasurements(temperature:Double?, humidity:Double?, pressure:Double?) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        measurementsChanged()
    }
}


class CurrentConditions: Observer {
    private var temperature:Double?
    private var humidity:Double?
    private var pressure:Double?
    private var weatherData:Subject?
    
    init(weatherData:Subject) {
        self.weatherData = weatherData
        self.weatherData?.registerObserver(self)
    }
    
    func update(temperature: Double?, humidity: Double?, pressure: Double?) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        display()
    }
    
    func display() {
        print("Current temperature is \(temperature)\nCurrent humidity is \(humidity)\nCurrent pressure is \(pressure)\n")
    }
}

func == (lhs: CurrentConditions, rhs: CurrentConditions) -> Bool {
    return lhs.temperature == rhs.temperature && lhs.humidity == rhs.humidity && lhs.pressure == rhs.pressure
}


class ForecastConditions: Observer {
    private var temperature:Double?
    private var pressure:Double?
    private var weatherData:Subject?
    
    init(weatherData:Subject) {
        self.weatherData = weatherData
        self.weatherData?.registerObserver(self)
    }
    
    func update(temperature: Double?, humidity: Double?, pressure: Double?) {
        self.temperature = temperature
        self.pressure = pressure
        display()
    }
    
    func display() {
        print("Forecast temperature is \(temperature)\n Forecast pressure is \(pressure)\n")
    }
}


var spb = WeatherData()
var cc = CurrentConditions(weatherData: spb)
var fc = ForecastConditions(weatherData: spb)
spb.setMeasurements(25, humidity: 60, pressure: 750)
spb.removeObserver(cc)
spb.setMeasurements(22, humidity: 80, pressure: 776)
