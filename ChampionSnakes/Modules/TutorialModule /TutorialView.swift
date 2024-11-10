import SwiftUI

struct TutorialView: View {
    @State var currentIndex = 0
    @State private var isLinkVisible = false
    var tutorialArray = ["tutorial1","tutorial2","tutorial3","tutorial4","tutorial5",]
    var body: some View {
        NavigationView {
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
