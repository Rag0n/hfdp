// абстрактная команда, используем для инкапсуляции классов устройств(устройство + операции)
// в результате при добавлении новых классов устройств
// не нужно будет изменять управляющий класс пульта(remoteControl)
protocol Command {
    func execute()
    // поддержка отмены команды
    func undo()
}


// классы конкретных комманд, инкапсулируют запросы к конкретным устройствам
class NoCommand: Command {
    func execute() {
        print("No command")
    }
    
    func undo() {
        print("No command")
    }
}

class LightOnCommand: Command {
    // объект-получатель
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        // методы, которые нужно вызвать, без аргументов
        light.on()
    }
    
    func undo() {
        light.off()
    }
}

class LightOffCommand: Command {
    // объект-получатель
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        // методы, которые нужно вызвать, без аргументов
        light.off()
    }
    
    func undo() {
        light.on()
    }
}

class StereoOnWithCDCommand: Command {
    // объект-получатель
    private let stereo: Stereo
    
    init(stereo: Stereo) {
        self.stereo = stereo
    }
    
    func execute() {
        // методы, которые нужно вызвать, без аргументов
        stereo.on()
        stereo.setCD()
        stereo.setVolume()
    }
    
    func undo() {
        // ...
    }
}

class GarageOpenCommand: Command {
    // объект-получатель
    private let garage: Garage
    
    init(garageDoor: Garage) {
        self.garage = garageDoor
    }
    
    func execute() {
        // методы, которые нужно вызвать, без аргументов
        garage.openDoor()
    }
    
    func undo() {
        garage.closeDoor()
    }
}

class GarageCloseCommand: Command {
    // объект-получатель
    private let garage: Garage
    
    init(garageDoor: Garage) {
        self.garage = garageDoor
    }
    
    func execute() {
        // методы, которые нужно вызвать, без аргументов
        garage.closeDoor()
    }
    
    func undo() {
        garage.openDoor()
    }
}

// Инициатор: все-равно какое устройство(оно инкапсулировано в конкретных коммандах)
// Важно лишь то, что конкретные команды реализуют интерфейс команды
class RemoteControl {
    private var onCommands: [Command]
    private var offCommands: [Command]
    private var undoCommand: Command // хваним ссылку на последнюю выполненную команду
    
    init() {
        onCommands = [Command](count: 7, repeatedValue: NoCommand())
        offCommands = [Command](count: 7, repeatedValue: NoCommand())
        undoCommand = NoCommand()
    }
    
    func setCommand(indexOfSlot: Int, onCommand: Command, offCommand: Command) {
        onCommands[indexOfSlot] = onCommand
        offCommands[indexOfSlot] = offCommand
    }
    
    func onButtonPressed(indexOfSlot: Int) {
        onCommands[indexOfSlot].execute()
        undoCommand = onCommands[indexOfSlot]
    }
    
    func offButtonPressed(indexOfSlot: Int) {
        offCommands[indexOfSlot].execute()
        undoCommand = offCommands[indexOfSlot]
    }
    
    func undoButtonPressed() {
        print("Undo:")
        undoCommand.undo()
        print("\n")
    }
}

// устройства
class Light {
    private let site: String
    
    init(site: String) {
        self.site = site
    }
    
    func on() {
        print("Light in \(site) is on")
    }
    
    func off() {
        print("Light in \(site) is off")
    }
}

class Garage {
    func openDoor() {
        print("Garage door is open")
    }
    
    func closeDoor() {
        print("Garage door is closed")
    }
}

class Stereo {
    func on() {
        print("Stereo is on")
    }
    
    func setCD() {
        print("CD is set")
    }
    
    func setVolume() {
        print("Volume is set")
    }
}

let livingRoomLight = Light(site: "Living Room")
let livingRoomLightOn = LightOnCommand(light: livingRoomLight)
let livingRoomLightOff = LightOffCommand(light: livingRoomLight)

let kitchenLight = Light(site: "Kitchen")
let kitchenLightOn = LightOnCommand(light: kitchenLight)
let kitchenLightOff = LightOffCommand(light: kitchenLight)

let garage = Garage()
let garageOpen = GarageOpenCommand(garageDoor: garage)
let garageClose = GarageCloseCommand(garageDoor: garage)

// remote - инициатор(invoker)
let remote = RemoteControl()
remote.setCommand(0, onCommand: livingRoomLightOn, offCommand: livingRoomLightOff)
remote.setCommand(1, onCommand: kitchenLightOn, offCommand: kitchenLightOff)
remote.setCommand(2, onCommand: garageOpen, offCommand: garageClose)

remote.onButtonPressed(0)
remote.offButtonPressed(0)
remote.undoButtonPressed()

remote.onButtonPressed(1)
remote.offButtonPressed(1)

remote.onButtonPressed(2)
remote.offButtonPressed(2)

remote.onButtonPressed(3)
remote.offButtonPressed(3)
