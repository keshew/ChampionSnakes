import SwiftUI

struct LevelView: View {
    @State var isGameViewAvailible = false
    @State var isMenuViewAvailible = false
    @State var levelNumber = UserDefaultsManager.defaults.object(forKey: Keys.levelNumber.rawValue) as? Int ?? 0 - 1
    @Binding var countWinOrLose: Int
    @State var backgroundColorOfImage = Color.green
    
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
                                        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
                                        .cornerRadius(20)
                                } else if countWinOrLose == 2 {
                                    Text("LEVEL \(levelNumber) failed")
                                        .frame(width: 200, height: 20)
                                        .font(.custom("Sequel-Regular", size: 20).bold())
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding()
                                        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
                                        .cornerRadius(20)
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
                    .foregroundColor(.white)
                    .frame(width: 35, height: 35)
                    .padding()
                    .background(backgroundColorOfImage)
                    .cornerRadius(40)
                    .bold()
            }
        }
        .padding(EdgeInsets(top: 30, leading: 15, bottom: 30, trailing: 15))
        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
        .cornerRadius(40)
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
        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
        .cornerRadius(20)
        .onAppear {
            level = UserDefaultsManager.defaults.object(forKey: Keys.levelNumber.rawValue) as? Int ?? 0
        }
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
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .bold()
            }
            
        }
        .frame(width: 195, height: 88)
        .padding()
        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
        .cornerRadius(20)
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
                        .fill((Color(#colorLiteral(red: 159/255, green: 233/255, blue: 221/255, alpha: 1))))
                        .frame(width: 80, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(#colorLiteral(red: 96/255, green: 154/255, blue: 138/255, alpha: 1)), lineWidth: 2)
                        )
                        .rotation3DEffect(.degrees(10), axis: (x: 1.0, y: 0.0, z: 0.0))
                        .offset(y: 355 - CGFloat(rectangle * 120))
                        .opacity(rectangle < (levelNumberRectangle - 1) ? 0.5 : 1)
                }
                
                ForEach(0...3, id: \.self) { shodowRectangle in
                    Rectangle()
                        .fill((Color(#colorLiteral(red: 159/255, green: 253/255, blue: 221/255, alpha: 1))))
                        .frame(width: 80, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(#colorLiteral(red: 96/255, green: 154/255, blue: 138/255, alpha: 1)), lineWidth: 2)
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

