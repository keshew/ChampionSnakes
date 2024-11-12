import SwiftUI

struct PauseView: View {
    @Binding var colorOfBack: Color
    @State var isMenuActive = false
    @State var isBackActive = false
    @State var sunCount = UserDefaultsManager.defaults.object(forKey: Keys.sunCount.rawValue)
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    HStack {
                        Text("\(sunCount ?? 0)")
                            .font(.custom("Sequel-Regular", size: 42).bold())
                            .foregroundColor(.white)
                            .offset(y: -3)
                        
                        Image(systemName: "sun.min.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.yellow)
                            .frame(width: 35, height: 55)
                    }
                    .frame(minWidth: 100, maxWidth: 135, minHeight: 58, maxHeight: 58)
                    .padding()
                    .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 4)
                    )
                }
                .padding()
                Spacer()
                
                TitleView(titleText: "PAUSE")
                Spacer()
                VStack(spacing: -10) {
                    HStack {
                        Button(action: {
                            isMenuActive = true
                        }) {
                            Text("MENU")
                                .frame(width: 155, height: 48)
                                .padding()
                                .background(.white)
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
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 4)
                    )
                    .padding()
                    
                    HStack {
                        Button(action: {
                            isBackActive = true
                        }) {
                            Text("RETRY")
                                .frame(width: 155, height: 48)
                                .padding()
                                .background(.white)
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
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 4)
                    )
                    .padding()
                }
                Spacer(minLength: 200)

                    .navigationDestination(isPresented: $isMenuActive) {
                        MenuView()
                    }

            }
           
        }
        .navigationBarBackButtonHidden()
    }
}
