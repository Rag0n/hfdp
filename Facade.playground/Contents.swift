// компоненты подсистемы
class Ampifier {
    func on() { }
    func setCD() { }
    func setDVD() { }
    func off() { }
    func setVolume() { }
    
}

class Tuner {
    
}

class CDPlayer {
    func on() { }
    func off() { }
    func play() { }
    func pause() { }
}

class Projector {
    func on() { }
    func off() { }
    func wideScreenModeOn() { }
    func wideScreenModeOff() { }
}

class TheaterLights  {
    func dim() { }
}

class Screen {
    func up() { }
    func down() { }
}

class PopcornPopper {
    func on() { }
    func pop() { }
    func off() { }
}

// фасад
class HomeTheaterFacade {
    // компоненты подсистемы, которые будет использовать фасад
    private let ampifier: Ampifier
    private let tuner: Tuner
    private let cdPlayer: CDPlayer
    private let projector: Projector
    private let theaterLights: TheaterLights
    private let screen: Screen
    private let popcornPopper: PopcornPopper
    
    init(ampifier: Ampifier, tuner: Tuner, cdPlayer: CDPlayer,
        projector: Projector, theaterLights: TheaterLights,
        screen: Screen, popper: PopcornPopper) {
        self.ampifier = ampifier
        self.tuner = tuner
        self.cdPlayer = cdPlayer
        self.projector = projector
        self.theaterLights = theaterLights
        self.screen = screen
        self.popcornPopper = popper
    }
    
    func watchMovie(movie: String) {
        print("Get ready to watch \(movie)")
        popcornPopper.on()
        popcornPopper.pop()
        theaterLights.dim()
        screen.down()
        projector.on()
        projector.wideScreenModeOn()
        ampifier.on()
        ampifier.setCD()
        ampifier.setVolume()
        cdPlayer.on()
        cdPlayer.play()
    }
    
    func endMovie() {
        print("Shutting down")
        popcornPopper.off()
        screen.up()
        projector.off()
        ampifier.off()
        cdPlayer.off()
    }
}