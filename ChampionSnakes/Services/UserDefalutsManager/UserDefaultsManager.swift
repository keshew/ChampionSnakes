import Foundation

enum Keys: String {
    case isFirstLauchKey = "hasLaunchedBefore"
    case levelNumber = "levelNumber"
    case levelNumberRectangle = "levelNumberRectangle"
    case levelNumberBasket = "levelNumberBasket"
    case levelNumberRectangleBasket = "levelNumberRectangleBasket"
    case sunCount = "sunCount"
}

class UserDefaultsManager {
    static let defaults = UserDefaults.standard
    private var currentLevel = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangle.rawValue) as? Int ?? 0
    
    func isFirstTime(isFirstLaunch: Bool) {
        if isFirstLaunch {
            UserDefaultsManager.defaults.set(true, forKey: Keys.isFirstLauchKey.rawValue)
        }
    }
    
    func clearLevelCount() {
        if UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangle.rawValue) as? Int ?? 0 > 4 {
            UserDefaultsManager.defaults.set(1, forKey: Keys.levelNumberRectangle.rawValue)
        }
    }
    
    func clearLevelCountBasket() {
        if UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangleBasket.rawValue) as? Int ?? 0 > 4 {
            UserDefaultsManager.defaults.set(1, forKey: Keys.levelNumberRectangleBasket.rawValue)
        }
    }
    
    func addSun() {
        let current = UserDefaultsManager.defaults.object(forKey: Keys.sunCount.rawValue)
        UserDefaultsManager.defaults.set((current as? Int ?? 0) + 1, forKey: Keys.sunCount.rawValue)
    }
    
    func levelCompleted() {
        let current = UserDefaultsManager.defaults.object(forKey: Keys.levelNumber.rawValue)
        let current2 = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangle.rawValue)
        UserDefaultsManager.defaults.set((current as? Int ?? 0) + 1, forKey: Keys.levelNumber.rawValue)
        UserDefaultsManager.defaults.set((current2 as? Int ?? 0) + 1, forKey: Keys.levelNumberRectangle.rawValue)
    }
    
    func levelCompletedBasket() {
        let current = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberBasket.rawValue)
        let current2 = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangleBasket.rawValue)
        UserDefaultsManager.defaults.set((current as? Int ?? 0) + 1, forKey: Keys.levelNumberBasket.rawValue)
        UserDefaultsManager.defaults.set((current2 as? Int ?? 0) + 1, forKey: Keys.levelNumberRectangleBasket.rawValue)
    }
    
    func getNumberOfLevel() -> Int {
        UserDefaultsManager.defaults.object(forKey: Keys.levelNumber.rawValue) as! Int
    }
}

