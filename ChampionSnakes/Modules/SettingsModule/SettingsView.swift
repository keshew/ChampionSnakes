import SwiftUI

struct SettingsView: View {
    @State var currentIndexMusic = 0
    @State var currentIndexSound = 0
    @State var isBackButtonTapped = false
    @State var backgroundColorOfImage = Color.white
    
    var arrayOfMusic = ["0%", "10%", "20%", "30%", "40%", "50%","60%", "70%","80%", "90%", "100%"]
    
    var arrayOfSounds = ["0%", "10%", "20%", "30%", "40%", "50%","60%", "70%","80%", "90%", "100%"]
    
    func backButtonAction() {
        isBackButtonTapped = true
    }
    
    func settingsButtonACtion() {
        
    }
    
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    ButtonView(backgroundColorOfImage: $backgroundColorOfImage, imageForButton: "chevron.backward", action: backButtonAction)
                    Spacer()
                    ButtonView(backgroundColorOfImage: $backgroundColorOfImage, imageForButton: "gear", action: settingsButtonACtion)
                }
                .padding()
                Spacer()
                VStack {
                    Spacer()
                    TitleView(titleText: "MUSIC")
                        .offset(y: -20)
                        Text("\(arrayOfMusic[currentIndexMusic])")
                            .font(.custom("Sequel-Regular", size: 42).bold())
                            .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .padding(EdgeInsets(top: 30, leading: 15, bottom: 30, trailing: 15))
                    .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
                    .cornerRadius(40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.white, lineWidth: 4)
                    )
                    
                    Button(action: {
                        currentIndexMusic = currentIndexMusic - 1
                    }) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .padding()
                            .bold()
                            .foregroundColor(.red)
                            .background(currentIndexMusic == 0 ? Color.gray : Color.white)
                            .cornerRadius(30)
                    }
                    .disabled(currentIndexMusic == 0 ? true : false)
                    .offset(x: -115, y: -90)
                
                    Button(action: {
                        currentIndexMusic = currentIndexMusic + 1
                    }) {
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .padding()
                            .bold()
                            .foregroundColor(.red)
                            .background(currentIndexMusic == 10 ? Color.gray : Color.white)
                            .cornerRadius(30)
                    }
                    .disabled(currentIndexMusic == 10 ? true : false)
                    .offset(x: 115, y: -155)
                }
                
                Spacer()
                VStack {
                    TitleView(titleText: "SOUNDS")
                        .offset(y: -20)
                    VStack {
                        
                        Text("\(arrayOfSounds[currentIndexSound])")
                            .font(.custom("Sequel-Regular", size: 42).bold())
                            .foregroundColor(.white)
                    }
                    .frame(width: 200, height: 50)
                    .padding(EdgeInsets(top: 30, leading: 15, bottom: 30, trailing: 15))
                    .background((Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1))))
                    .cornerRadius(40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.white, lineWidth: 4)
                    )
                    
                    Button(action: {
                        currentIndexSound = currentIndexSound - 1
                    }) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .padding()
                            .bold()
                            .foregroundColor(.red)
                            .background(currentIndexSound == 0 ? Color.gray : Color.white)
                            .cornerRadius(30)
                    }
                    .disabled(currentIndexSound == 0 ? true : false)
                    .offset(x: -115, y: -90)
                
                    Button(action: {
                        currentIndexSound = currentIndexSound + 1
                    }) {
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .padding()
                            .bold()
                            .foregroundColor(.red)
                            .background(currentIndexSound == 10 ? Color.gray : Color.white)
                            .cornerRadius(30)
                    }
                    .disabled(currentIndexSound == 10 ? true : false)
                    .offset(x: 115, y: -155)
                }
                Spacer()
            }
        }
        .navigationDestination(isPresented: $isBackButtonTapped) {
            MenuView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsView()
}
