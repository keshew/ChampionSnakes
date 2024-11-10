import SwiftUI

struct TutorialView: View {
    @State var currentIndex = 0
    var tutorialArray = ["tutorial1","tutorial2","tutorial3","tutorial4","tutorial5",]
    var body: some View {
        ZStack {
            Image(tutorialArray[currentIndex])
                .resizable()
                .ignoresSafeArea()
   
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                    currentIndex = currentIndex + 1
                    }) {
                        Image("clearImage")
                            .resizable()
                            .ignoresSafeArea()
                    }
                    .frame(width: 393, height: 852)
                    
                }
            }
        }
    }
}

#Preview {
    TutorialView()
}
