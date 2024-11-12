import SwiftUI

struct MenuView: View {
    @State var valueForModeSlider: Double = 0.5
    @State var valueForGameSlider: Double = 0.5
    @State var selectedOption = "LEVELS"
    @State var currentIndex = 0
    @State var currentGame = 0
    @State var isPlayButtonTapped = false
    @State var isBasketBallShow = false
    @State var isSettingsButtonTapped = false
    @State var isForwardButtonActive = true
    @State var isBackButtonActive = true
    @State var image = "football"
    @State var arrayOfFootbal = ["football", "basketball", "tennis"]
    @State var arrayOfBasketball = ["basketball", "tennis", "football"]
    @State var arrayOfTennis = ["tennis", "football", "basketball"]
    @State var statusGameToogle = "GAME"
    @State var statusGameMode = "LEVELS"
    @State var isModeSlider = true
    @State var isGameSlider = false
    @State var backgroundColorOfImage = Color.white
    @State var sunCount  = UserDefaultsManager.defaults.object(forKey: Keys.sunCount.rawValue) as? Int ?? 0
    
    let options = ["LEVELS", "ENDLESS"]
    
    func buttonAction() {
        if currentIndex == 0 {
            isPlayButtonTapped = true
        } else if currentIndex == 1/*, sunCount > 50 */{
            isBasketBallShow = true
        }
    }
    
    func settingsActivate() {
        isSettingsButtonTapped = true
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        BalanceWithTitle(sunCount: $sunCount)
                        ButtonView(backgroundColorOfImage: $backgroundColorOfImage, imageForButton: "gear", action: settingsActivate)
                        ButtonView(backgroundColorOfImage: $backgroundColorOfImage, imageForButton: "play", action: buttonAction)
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                    
                    VStack() {
                        TitleView(titleText: "MODE")
                        ModeSegmentedPicker(isModeSlider: $isModeSlider, value: $valueForModeSlider, statusGameToogle: $statusGameToogle, statusGameMode: $statusGameMode, height: 30, heightOfGreen: 1.3)
                        
                        
                    }
                    Spacer()
                    VStack {
                        TitleView(titleText: "SPORT")
                        ZStack {
                            if currentIndex == 0 {
                                ImageOfSport(currentIndex: $currentIndex, arrayOfSport: $arrayOfBasketball, offset: 50)
                                ImageOfSport(currentIndex: $currentIndex, arrayOfSport: $arrayOfFootbal, height: 229)
                                ForwardButton(currentIndex: $currentIndex)
                            } else if currentIndex == 2 {
                                ImageOfSport(currentIndex: $currentIndex, arrayOfSport: $arrayOfTennis, offset: -50)
                                
                                   
                                ImageOfSport(currentIndex: $currentIndex, arrayOfSport: $arrayOfFootbal, height: 229)
                                    .overlay {
                                        Text("TO UNLOCK THIS MODE YOU NEED 150 STARS")
                                            .font(.custom("Sequel-Regular", size: 22))
                                            .foregroundColor(.white)
                                            .bold()
                                            .multilineTextAlignment(.center)
                                            .frame(width: 150, height: 200)
                                    }
                                BackwardButton(currentIndex: $currentIndex)
                            } else {
                                ImageOfSport(currentIndex: $currentIndex, arrayOfSport: $arrayOfBasketball, offset: 50)
                             
                                ImageOfSport(currentIndex: $currentIndex, arrayOfSport: $arrayOfTennis, offset: -50)
                                
                                ImageOfSport(currentIndex: $currentIndex, arrayOfSport: $arrayOfFootbal, height: 229)
                                    .overlay {
                                        Text("TO UNLOCK THIS MODE YOU NEED 50 STARS")
                                            .font(.custom("Sequel-Regular", size: 22))
                                            .foregroundColor(.white)
                                            .bold()
                                            .multilineTextAlignment(.center)
                                            .frame(width: 150, height: 200)
                                    }
                                ForwardButton(currentIndex: $currentIndex)
                                BackwardButton(currentIndex: $currentIndex)
                            }
                        }
                        .frame(width: 399, height: 259)
                        .frame(minWidth: 100, maxWidth: 399, minHeight: 88, maxHeight: 259)
                        
                        ModeSegmentedPicker(isModeSlider: $isGameSlider, value: $valueForGameSlider, statusGameToogle: $statusGameToogle, statusGameMode: $statusGameMode, height: 40)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isPlayButtonTapped) {
                LevelView(countWinOrLose: $currentGame)
            }
            .navigationDestination(isPresented: $isSettingsButtonTapped) {
                SettingsView()
            }
            
            .navigationDestination(isPresented: $isBasketBallShow) {
                LevelBasketView(countWinOrLose: $currentGame)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}



#Preview {
    MenuView()
}

struct ModeSegmentedPicker: View {
    @Binding var isModeSlider: Bool
    @Binding var value: Double
    @Binding var statusGameToogle: String
    @Binding var statusGameMode: String
    var height: Double
    var heightOfGreen = 1.1
    
    func updateValue(with geasture: DragGesture.Value, in geometry: GeometryProxy) {
        let newValue = geasture.location.x
        value = min(max(Double(newValue), 0.0), 1)
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width / 1, height: height)
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(lineWidth: 20)
                        .foregroundColor(Color(#colorLiteral(red: 145/255, green: 39/255, blue: 1/255, alpha: 1)))
                        .frame(width: geometry.size.width / 1, height: height + 15)
                    
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1)))
                    
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1)), lineWidth: 0)
                        }
                        .overlay {
                            if isModeSlider {
                                Text(statusGameMode)
                                    .font(.custom("Sequel-Regular", size: 22))
                                    .foregroundColor(.white)
                                    .bold()
                            } else {
                                Text(statusGameToogle)
                                    .font(.custom("Sequel-Regular", size: 22))
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height / heightOfGreen)
                .offset(x: CGFloat(value) * geometry.size.width / 15, y: -2)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { geasture in
                            if abs(geasture.translation.width) > abs(geasture.translation.height) {
                                updateValue(with: geasture, in: geometry)
                                if value == 0 {
                                    if isModeSlider {
                                        statusGameMode = "LEVELS"
                                    } else {
                                        statusGameToogle = "GAME"
                                    }
                                } else {
                                    value = value * 7.5
                                    if isModeSlider {
                                        statusGameMode = "ENDLESS"
                                    } else {
                                        statusGameToogle = "RECORD"
                                    }
                                }
                            }
                        }
                )
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 40)
        .padding()
    }
}

struct BalanceWithTitle: View {
    @Binding var sunCount: Int
    var body: some View {
        VStack {
            Text("BALANCE")
                .font(.custom("Sequel-Regular", size: 22))
                .foregroundColor(.white)
            HStack(spacing: 10) {
                Text("\(sunCount)")
                    .font(.custom("Sequel-Regular", size: 42).bold())
                    .foregroundColor(.white)
                    .offset(y: -3)
                
                Image(systemName: "sun.min.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.yellow)
                    .frame(width: 35, height: 55)
            }
        }
        .frame(minWidth: 100, maxWidth: 135, minHeight: 88, maxHeight: 88)
        .padding()
        .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
        .cornerRadius(20)
        .overlay(
              RoundedRectangle(cornerRadius: 20)
                  .stroke(.white, lineWidth: 3)
          )
    }
}

struct TitleView: View {
    var titleText: String
    var body: some View {
        HStack {
            Text(titleText)
                .font(.custom("Sequel-Regular", size: 22))
                .foregroundColor(.white)
        }
        .frame(width: 197, height: 45)
        .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
        .cornerRadius(50)
        .overlay(
              RoundedRectangle(cornerRadius: 20)
                  .stroke(.white, lineWidth: 3)
          )
    }
}

struct BackwardButton: View {
    @Binding var currentIndex: Int
    var body: some View {
        Button(action: {
            currentIndex = currentIndex - 1
        }) {
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
                .padding()
                .bold()
                .foregroundColor(.white)
                .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
                .cornerRadius(30)
        }
        .disabled(currentIndex == 0 ? true : false)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white, lineWidth: 2)
        )
        .offset(x: -115)
    }
}

struct ForwardButton: View {
    @Binding var currentIndex: Int
    var body: some View {
        Button(action: {
            currentIndex = currentIndex + 1
        }) {
            Image(systemName: "chevron.forward")
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
                .padding()
                .bold()
                .foregroundColor(.white)
                .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
                .cornerRadius(30)
            
        }
        .disabled(currentIndex == 2 ? true : false)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white, lineWidth: 2)
        )
        .offset(x: 115)
    }
}

struct ImageOfSport: View {
    @Binding var currentIndex: Int
    @Binding var arrayOfSport: [String]
    var offset: CGFloat = 0
    var height: CGFloat = 189
    
    var body: some View {
        Image(arrayOfSport[currentIndex])
            .resizable()
            .frame(width: 231, height: height)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 5)
            )
            .offset(x: offset)
    }
}
