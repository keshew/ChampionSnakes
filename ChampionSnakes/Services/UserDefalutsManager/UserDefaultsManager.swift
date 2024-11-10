import Foundation

enum Keys: String {
    case recordDataSinceFirstLaunchKey = "firstLaunchKey"
    case isFirstLauchKey = "hasLaunchedBefore"
}

class UserDefaultsManager {
    static let defaults = UserDefaults.standard
    
    func isFirstTime(isFirstLaunch: Bool) {
        if isFirstLaunch {
            UserDefaultsManager.defaults.set(true, forKey: Keys.isFirstLauchKey.rawValue)
        }
    }
}

