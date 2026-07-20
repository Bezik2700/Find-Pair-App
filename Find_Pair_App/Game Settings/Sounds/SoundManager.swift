import AVFoundation
import Combine

class SoundManager {
    
    static let shared = SoundManager()
        
    private var backgroundPlayer: AVAudioPlayer?
    private var effectPlayer: AVAudioPlayer?
        
    var isMusicEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "isMusicEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "isMusicEnabled") }
    }
        
    var isSoundEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "isSoundEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "isSoundEnabled") }
    }
        
    private init() {
        if UserDefaults.standard.object(forKey: "isMusicEnabled") == nil {
            UserDefaults.standard.set(true, forKey: "isMusicEnabled")
        }
        if UserDefaults.standard.object(forKey: "isSoundEnabled") == nil {
            UserDefaults.standard.set(true, forKey: "isSoundEnabled")
        }
    }
    
    func playBackgroundMusic(_ fileName: String) {
        guard isMusicEnabled else { return }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("❌ File \(fileName).mp3 not find")
            return
        }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.volume = 0.35
            backgroundPlayer?.play()
        } catch {
            print("❌ Error: \(error)")
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
            print("❌ File \(fileName).mp3 not find")
            return
        }
        
        do {
            effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer?.volume = 0.7
            effectPlayer?.play()
        } catch {
            print("❌ Error: \(error)")
        }
    }
    
    func playHintSound() {
        guard isSoundEnabled else { return }
        playEffect("hint_score")
    }
    func playMultiSound() {
        guard isSoundEnabled else { return }
        playEffect("multi_sound")
    }
    func playCardFlip() {
        guard isSoundEnabled else { return }
        playEffect("card_flip")
    }
}
