import SwiftUI

struct LevelView: View {
    var body: some View {
        
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack {
                VStack {
                    VStack {
                        HStack {
                            BackButtonView()
                            Spacer()
                            LabelLevelView()
                        }
                        .padding()
                    }
                }
                Spacer()
                StartView()
                    .padding()
            }
        }
    }
}

#Preview {
    LevelView()
}


//ForEach(0...12, id: \.self) { col in
//                if col < 5 {
//                    Rectangle()
//                        .fill((Color(#colorLiteral(red: 159/255, green: 233/255, blue: 221/255, alpha: 1))))
//                        .frame(width: 80, height: 80) // Устанавливаем размер
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 0)
//                                .stroke(Color(#colorLiteral(red: 96/255, green: 154/255, blue: 138/255, alpha: 1)), lineWidth: 2)
//                        )
//                        .rotationEffect(.degrees(50))
//                        .offset(x: -110 + CGFloat(col * 60), y: 200 + CGFloat(col * -50))
//                    //                    .offset(x: 120 * CGFloat(col))
//                } else if col < 9 {
//                    Rectangle()
//                        .fill((Color(#colorLiteral(red: 159/255, green: 233/255, blue: 221/255, alpha: 1))))
//                        .frame(width: 80, height: 80) // Устанавливаем размер
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 0)
//                                .stroke(Color(#colorLiteral(red: 96/255, green: 154/255, blue: 138/255, alpha: 1)), lineWidth: 2)
//                        )
//                        .rotationEffect(.degrees(-40))
//                        .offset(x: 295 - CGFloat(col * 43) , y: 196 - CGFloat(col * 51) )
//                } else {
//                    Rectangle()
//                        .fill((Color(#colorLiteral(red: 159/255, green: 233/255, blue: 221/255, alpha: 1))))
//                        .frame(width: 80, height: 80) // Устанавливаем размер
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 0)
//                                .stroke(Color(#colorLiteral(red: 96/255, green: 154/255, blue: 138/255, alpha: 1)), lineWidth: 2)
//                        )
//                        .rotationEffect(.degrees(50))
//                        .offset(x: -110 + CGFloat(col * 60), y: -200 + CGFloat(col * -50))
//                }
//            }

private struct BackButtonView: View {
    var body: some View {
        VStack {
            Button(action: {
                
            }) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 35, height: 35)
                    .padding()
                    .background(.green)
                    .cornerRadius(40)
                    .bold()
            }
        }
        .padding(EdgeInsets(top: 30, leading: 15, bottom: 30, trailing: 15))
        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
        .cornerRadius(40)
    }
}

private struct LabelLevelView: View {
    var body: some View {
        HStack {
            Text("LEVEL")
                .font(.custom("Sequel-Regular", size: 30).bold())
                .foregroundColor(.white)
            
                .bold()
            
            Text("1")
                .font(.custom("Sequel-Regular", size: 70))
                .foregroundColor(.white)
                .offset(y: -10)
                .bold()
        }
        .frame(width: 195, height: 88)
        .padding()
        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
        .cornerRadius(20)
    }
}

private struct StartView: View {
    var body: some View {
        HStack {
            Text("PLAY")
                .padding()
                .background(.green)
                .font(.custom("Sequel-Regular", size: 30).bold())
                .foregroundColor(.white)
                .cornerRadius(20)
                .bold()
     
        }
        .frame(width: 195, height: 88)
        .padding()
        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
        .cornerRadius(20)
    }
}
