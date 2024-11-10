import SwiftUI

struct ContentView: View {
    @State private var isFirstLaunch: Bool = false
    private var progressViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if isFirstLaunch {
                TutorialView()
            } else {
                MenuView()
            }
        }
        .onAppear(perform: checkFirstLaunch)
    }

    func checkFirstLaunch() {
        isFirstLaunch = !UserDefaultsManager.defaults.bool(forKey: Keys.isFirstLauchKey.rawValue)
        UserDefaultsManager().isFirstTime(isFirstLaunch: isFirstLaunch)
        print(isFirstLaunch)
        if isFirstLaunch {
            UserDefaultsManager.defaults.set(1, forKey: Keys.levelNumberRectangle.rawValue)
            UserDefaultsManager.defaults.set(1, forKey: Keys.levelNumber.rawValue)
            UserDefaultsManager.defaults.set(1, forKey: Keys.sunCount.rawValue)
            UserDefaultsManager.defaults.set(1, forKey: Keys.levelNumberRectangleBasket.rawValue)
            UserDefaultsManager.defaults.set(1, forKey: Keys.levelNumberBasket.rawValue)
        }
    }
}

#Preview {
    ContentView()
}
