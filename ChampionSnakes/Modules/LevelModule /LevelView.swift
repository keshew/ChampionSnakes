import SwiftUI

struct LevelView: View {
    @State var isGameViewAvailible = false
    @State var isMenuViewAvailible = false
    @State var levelNumber = UserDefaultsManager.defaults.object(forKey: Keys.levelNumber.rawValue) as? Int ?? 0 - 1
    @Binding var countWinOrLose: Int
    @State var backgroundColorOfImage = Color.white
    
    func buttonAction() {
        isGameViewAvailible = true
    }
    
    func backButtonAction() {
        isMenuViewAvailible = true
    }
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack {
                ZStack {
                    VStack {
                        HStack {
                            ButtonView(backgroundColorOfImage: $backgroundColorOfImage, imageForButton: "chevron.backward", action: backButtonAction)
                            Spacer()
                            LabelLevelView()
                        }
                        .padding()
                        LevelRectangleView()
                            .overlay {
                                if countWinOrLose == 1 {
                                    Text("LEVEL \(levelNumber) COMPLETED")
                                        .frame(width: 200, height: 20)
                                        .font(.custom("Sequel-Regular", size: 20).bold())
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding()
                                        .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.white, lineWidth: 2)
                                        )
                                } else if countWinOrLose == 2 {
                                    Text("LEVEL \(levelNumber) failed")
                                        .frame(width: 200, height: 20)
                                        .font(.custom("Sequel-Regular", size: 20).bold())
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding()
                                        .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.white, lineWidth: 2)
                                        )
                                }
                            }
                        
                    }
                }
              
                Spacer()
                StartView(colorForBack: $backgroundColorOfImage, action: buttonAction)
            }
        }

        .navigationDestination(isPresented: $isGameViewAvailible) {
            GameView()
        }
        
        .navigationDestination(isPresented: $isMenuViewAvailible) {
            MenuView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ButtonView: View {
    @Binding var backgroundColorOfImage: Color
    var imageForButton: String
    var action: () -> Void
    var body: some View {
        VStack {
            Button(action: {
                action()
            }) {
                Image(systemName: imageForButton)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 35, height: 35)
                    .padding()
                    .background(backgroundColorOfImage)
                    .cornerRadius(40)
                    .bold()
            }
        }
        .padding(EdgeInsets(top: 30, leading: 15, bottom: 30, trailing: 15))
        .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
        .cornerRadius(40)
        .overlay(
              RoundedRectangle(cornerRadius: 40)
                  .stroke(.white, lineWidth: 3)
          )
    }
}

struct LabelLevelView: View {
    @State var level = UserDefaultsManager.defaults.object(forKey: Keys.levelNumber.rawValue) as? Int ?? 0
    var body: some View {
        HStack {
            Text("LEVEL")
                .font(.custom("Sequel-Regular", size: 30).bold())
                .foregroundColor(.white)
            
                .bold()
            
            Text("\(level)")
                .font(.custom("Sequel-Regular", size: 70))
                .foregroundColor(.white)
                .offset(x: 3, y: -10)
                .bold()
        }
        .frame(width: 195, height: 88)
        .padding()
        .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
        .cornerRadius(20)
        .onAppear {
            level = UserDefaultsManager.defaults.object(forKey: Keys.levelNumber.rawValue) as? Int ?? 0
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 4)
        )
    }
}
struct StartView: View {
    @Binding var colorForBack: Color
    var action: () -> Void
    var body: some View {
        HStack {
            Button(action: {
                action()
            }) {
                Text("PLAY")
                    .padding()
                    .background(colorForBack)
                    .font(.custom("Sequel-Regular", size: 30).bold())
                    .foregroundColor(.red)
                    .cornerRadius(20)
                    .bold()
            }
            
        }
        .frame(width: 195, height: 88)
        .padding()
        .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(.white, lineWidth: 4)
        )
        .padding()
    }
}

struct LevelRectangleView: View {
    @State var levelNumberRectangle = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangle.rawValue) as? Int ?? 0
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<levelNumberRectangle, id: \.self) { rectangle in
                    Rectangle()
                        .fill((Color(#colorLiteral(red: 160/255, green: 39/255, blue: 1/255, alpha: 1))))
                        .frame(width: 80, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(#colorLiteral(red: 110/255, green: 39/255, blue: 1/255, alpha: 1)), lineWidth: 2)
                        )
                        .rotation3DEffect(.degrees(10), axis: (x: 1.0, y: 0.0, z: 0.0))
                        .offset(y: 355 - CGFloat(rectangle * 120))
                        .opacity(rectangle < (levelNumberRectangle - 1) ? 0.5 : 1)
                }
                
                ForEach(0...3, id: \.self) { shodowRectangle in
                    Rectangle()
                        .fill((Color(#colorLiteral(red: 160/255, green: 39/255, blue: 1/255, alpha: 1))))
                        .frame(width: 80, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(#colorLiteral(red: 110/255, green: 39/255, blue: 1/255, alpha: 1)), lineWidth: 2)
                        )
                        .rotation3DEffect(.degrees((10)), axis: (x: 1.0, y: 0.0, z: 0.0))
                        .offset(y: 345 - CGFloat(shodowRectangle * 120))
                        .opacity(shodowRectangle < (levelNumberRectangle - 1) ? 0.5 : 1)
                }
            }
        }
        
        .onAppear() {
            UserDefaultsManager().clearLevelCount()
            print(levelNumberRectangle)
            levelNumberRectangle = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangle.rawValue) as? Int ?? 0
            print(levelNumberRectangle)
        }
    }
}

