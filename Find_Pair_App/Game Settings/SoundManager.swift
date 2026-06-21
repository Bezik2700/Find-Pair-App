import AVFoundation
import Combine

class SoundManager {
    
    static let shared = SoundManager()
    
    private var backgroundPlayer: AVAudioPlayer?
    private var effectPlayer: AVAudioPlayer?
    
    @Published var isMusicEnabled: Bool {
        didSet { UserDefaults.standard.set(isMusicEnabled, forKey: "isMusicEnabled") }
    }
    
    @Published var isSoundEnabled: Bool {
        didSet { UserDefaults.standard.set(isSoundEnabled, forKey: "isSoundEnabled") }
    }
    
    private init() {
        self.isMusicEnabled = UserDefaults.standard.object(forKey: "isMusicEnabled") as? Bool ?? true
        self.isSoundEnabled = UserDefaults.standard.object(forKey: "isSoundEnabled") as? Bool ?? true
    }
    
    func playBackgroundMusic(_ fileName: String) {
        guard isMusicEnabled else { return }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("❌ Файл \(fileName).mp3 не найден")
            return
        }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.volume = 0.5
            backgroundPlayer?.play()
        } catch {
            print("❌ Ошибка воспроизведения: \(error)")
        }
    }
    
    func stopBackgroundMusic() {
        backgroundPlayer?.stop()
    }
    
    func pauseBackgroundMusic() {
        backgroundPlayer?.pause()
    }
    
    func resumeBackgroundMusic() {
        guard isMusicEnabled else { return }
        backgroundPlayer?.play()
    }
    
    func playEffect(_ fileName: String) {
        guard isSoundEnabled else { return }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("❌ Файл \(fileName).mp3 не найден")
            return
        }
        
        do {
            effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer?.volume = 0.7
            effectPlayer?.play()
        } catch {
            print("❌ Ошибка воспроизведения: \(error)")
        }
    }
    
    func playHintSound() {
        guard isSoundEnabled else { return }
        playEffect("hint_sound")
    }
}
