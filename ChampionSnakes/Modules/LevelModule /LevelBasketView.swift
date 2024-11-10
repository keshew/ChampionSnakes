
import SwiftUI

struct LevelBasketView: View {
    @State var isGameViewAvailible = false
    @State var isMenuViewAvailible = false
    @State var levelNumber = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberBasket.rawValue) as? Int ?? 0 - 1
    @Binding var countWinOrLose: Int
    @State var backgroundColorOfImage = Color.yellow
    
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
                            LabelLevelViewBasket()
                        }
                        .padding()
                        LevelRectangleViewBasket()
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
            BasketballGameView()
        }
        
        .navigationDestination(isPresented: $isMenuViewAvailible) {
            MenuView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct LabelLevelViewBasket: View {
    @State var level = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberBasket.rawValue) as? Int ?? 0
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
            level = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberBasket.rawValue) as? Int ?? 0
        }
    }
}

struct LevelRectangleViewBasket: View {
    @State var levelNumberRectangleBasket = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangleBasket.rawValue) as? Int ?? 0
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<levelNumberRectangleBasket, id: \.self) { rectangle in
                    Rectangle()
                        .fill((Color(#colorLiteral(red: 159/255, green: 233/255, blue: 221/255, alpha: 1))))
                        .frame(width: 80, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(#colorLiteral(red: 96/255, green: 154/255, blue: 138/255, alpha: 1)), lineWidth: 2)
                        )
                        .rotation3DEffect(.degrees(10), axis: (x: 1.0, y: 0.0, z: 0.0))
                        .offset(y: 355 - CGFloat(rectangle * 120))
                        .opacity(rectangle < (levelNumberRectangleBasket - 1) ? 0.5 : 1)
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
                        .opacity(shodowRectangle < (levelNumberRectangleBasket - 1) ? 0.5 : 1)
                }
            }
        }
        
        .onAppear() {
            UserDefaultsManager().clearLevelCountBasket()
            levelNumberRectangleBasket = UserDefaultsManager.defaults.object(forKey: Keys.levelNumberRectangleBasket.rawValue) as? Int ?? 0
        }
    }
}
