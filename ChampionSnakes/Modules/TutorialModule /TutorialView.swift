import SwiftUI

struct TutorialView: View {
    @State var currentIndex = 0
    @State private var isLinkVisible = false
    var tutorialArrayImage = ["firstTutorial","secondTutorial","thirdTutorial","fourTutorial","firstTutorial"]
    var tutorialArrayLabel = ["HELLO CHAMPION! LET ME TELL YOU WHAT'S WHAT WE HAVE HERE!",
                              "THERE ARE TWO MODES IN OUR GAME - LEVELS AND ENDLESS",
                              "IN EACH OF THE LEVELS, YOU MOVE FORWARD THROUGH OBSTACLES AND EARN STARS, FOR WHICH YOU CAN UNLOCK NEW LEVELS LATER",
                              "WE ALSO HAVE A SECTION WITH PERSONAL RECORDS.",
                              "IT IS BETTER TO RECORD THE RESULTS THERE IN INFINITE MODE"]
    var offsetArrayY: [CGFloat] = [-160,20, -80, -180, -180]
    var offsetArrayX: [CGFloat] = [0,-40, -40, 40, 0]
    var frameArrayH: [CGFloat] = [358, 158, 158, 258, 358]
    var sizeArray: [CGFloat] = [34, 22, 16, 26, 36]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(tutorialArrayImage[currentIndex])
                    .resizable()
                    .ignoresSafeArea()
                
                ZStack {
                    Text(tutorialArrayLabel[currentIndex])
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.custom("Sequel-Regular", size: sizeArray[currentIndex]).bold())
                        .frame(width: 254, height: frameArrayH[currentIndex])
                        .background(Color(#colorLiteral(red: 250/255, green: 39/255, blue: 1/255, alpha: 1)))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white, lineWidth: 4)
                        )
                        .lineLimit(8)
                        .offset(x: offsetArrayX[currentIndex], y: offsetArrayY[currentIndex])
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            currentIndex = currentIndex + 1
                            if currentIndex == 4 {
                                isLinkVisible = true
                            }
                        }) {
                            Image("clearImage")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        .frame(width: 393, height: 852)
                        
                    }
                }
                
                if isLinkVisible {
                    NavigationLink(destination: MenuView()) {
                        Text("perehod")
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                            .foregroundColor(.clear)
                    }
                }
            }
        }
    }
}

#Preview {
    TutorialView()
}
