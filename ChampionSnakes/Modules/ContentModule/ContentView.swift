import SwiftUI

struct ContentView: View {
    @State private var isFirstLaunch: Bool = false
    private var progressViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if isFirstLaunch {
                Text("hey")
            } else {
                Text("hey again")
            }
        }
        .onAppear(perform: checkFirstLaunch)
    }

    func checkFirstLaunch() {
        isFirstLaunch = !UserDefaultsManager.defaults.bool(forKey: Keys.isFirstLauchKey.rawValue)
        UserDefaultsManager().isFirstTime(isFirstLaunch: isFirstLaunch)
    }
}

#Preview {
    ContentView()
}
