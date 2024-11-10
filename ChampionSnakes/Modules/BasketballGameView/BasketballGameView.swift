import SwiftUI

struct BasketballGameView: View {
    @State var value: Double = 0.5
    @State var ballXPosition: Double = 0.0
    @State var ballYPosition = CGPoint(x: 60, y: 500)
    @State private var offset: CGFloat = 0
    @State var numberOfBalls = 1
    @State var numberOfSuns = UserDefaultsManager.defaults.object(forKey: Keys.sunCount.rawValue) as? Int ?? 0
    @State var isLevelCompleted = false
    @State var isLevelFailed = false
    @State var isPause = false
    @State var backgroundColorOfImage = Color.yellow
    @State var timer: Timer?
    
    func buttonAction() {
        isPause = true
        timer?.invalidate()
    }
    
    var body: some View {
        ZStack {
            Image("basketballBackground")
                .resizable()
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        HStack(spacing: 10) {
                            Text("\(numberOfSuns)")
                                .font(.custom("Sequel-Regular", size: 42).bold())
                                .foregroundColor(.white)
                                .offset(y: -3)
                            
                            Image(systemName: "sun.min.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.yellow)
                                .frame(width: 35, height: 55)
                        }
                        .frame(minWidth: 100, maxWidth: 135, minHeight: 78, maxHeight: 78)
                        .padding()
                        .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
                        .cornerRadius(20)
                        Spacer()
                        ButtonView(backgroundColorOfImage: $backgroundColorOfImage, imageForButton: "pause", action: buttonAction)
                    }
//                    .offset(y: -180)
                    .padding()
                    
                    ZStack {
                        HStack {
                            ZStack {
                                ForEach(0..<numberOfBalls, id: \.self) { index in
                                    Image("ballBasketball")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .position(ballYPosition)
                                        .foregroundColor(.white)
                                        .offset(x: CGFloat(-index * 15), y: CGFloat(index * 15))
                                }
                                .offset(x: ballXPosition, y: -80)
                            }
                            
                            VerticalMovingNumbers(numberOfBalls: $numberOfBalls, numberOfSuns: $numberOfSuns, offset: $offset, isLevelCompleted: $isLevelCompleted, ballXPosition: $ballXPosition, ballYPosition: $ballYPosition, isLevelFailed: $isLevelFailed, timer: $timer)
                        }
                    }
                    .offset(y: -80)
                }
           
                
                HStack {
                    Button(action: {
                        withAnimation {
                            ballYPosition.y = ballYPosition.y - 50
                        }
                    }) {
                        Text("UP")
                            .frame(width: 155, height: 28)
                            .padding()
                            .background(.yellow)
                            .font(.custom("Sequel-Regular", size: 30).bold())
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .bold()
                    }
                }
                .frame(width: 195, height: 58)
                .padding()
                .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 2)
                }
                .offset(x: -10, y: 10)
                .padding()
            }
            .navigationDestination(isPresented: $isPause) {
                PauseView(colorOfBack: $backgroundColorOfImage)
            }
        }
    }
}

#Preview {
    BasketballGameView()
}

struct VerticalMovingNumbers: View {
    @Binding var numberOfBalls: Int
    @Binding var numberOfSuns: Int
    @Binding var offset: CGFloat
    @Binding var isLevelCompleted: Bool
    @Binding var ballXPosition: Double
    @Binding var ballYPosition: CGPoint
    @Binding var isLevelFailed: Bool
    @State var valueWinOrLose = 0
    @Binding var timer: Timer?
    @State private var position: CGPoint = CGPoint(x: 0, y: 0)
    @State private var position2: CGPoint = CGPoint(x: 0, y: 0)
    @State var finishImage = FinishModelw(imageName: "finishVertical", coordinates: CGPoint(x: 0, y: 0))
    
    @State var balls =
    AddBalls(countOfBalls: 3, coordinates: CGPoint(x: 280, y: 320))
    
    @State var sun =
    Sun(imageName: "sun.min.fill", coordinates: CGPoint(x: -50, y: 320))
    
    
    @State var elements = [
        Element(name: 1, indexPoint: 0,  coordinates: CGPoint(x: 60, y: 80 / 20)),
        Element(name: 1, indexPoint: 1,  coordinates: CGPoint(x: 60, y: 170 / 20)),
        Element(name: 1, indexPoint: 2,  coordinates: CGPoint(x: 60, y: 260 / 20)),
        Element(name: 1, indexPoint: 3,  coordinates: CGPoint(x:  60, y: 350 / 20)),
        Element(name: 1, indexPoint: 4,  coordinates: CGPoint(x: 60, y: 440 / 20)),
        Element(name: 1, indexPoint: 5,  coordinates: CGPoint(x: 60, y: 530 / 20))
    ]
    
    @State var elements2 = [
        Element(name: 1, indexPoint: 0,  coordinates: CGPoint(x: 60, y: 80 / 20)),
        Element(name: 2, indexPoint: 1,  coordinates: CGPoint(x: 60, y: 170 / 20)),
        Element(name: 3, indexPoint: 2,  coordinates: CGPoint(x: 60, y: 260 / 20)),
        Element(name: 4, indexPoint: 3,  coordinates: CGPoint(x:  60, y: 350 / 20)),
        Element(name: 5, indexPoint: 4,  coordinates: CGPoint(x: 60, y: 440 / 20)),
        Element(name: 6, indexPoint: 5,  coordinates: CGPoint(x: 60, y: 530 / 20))
    ]
    
    func ballDown() {
        ballYPosition.y = ballYPosition.y + 1
        if ballYPosition.y < 80 {
            ballYPosition.y = 80
        } else if ballYPosition.y > 590 {
            ballYPosition.y = 590
        }
        
    }
    func getFinish() {
        if finishImage.coordinates.x == CGFloat(-830) {
                        isLevelCompleted = true
                        valueWinOrLose = 1
            UserDefaultsManager().levelCompletedBasket()
            timer?.invalidate()
        }
    }
    
    func getBalls() {
        let rangeOfBall = 350...380
        if balls.coordinates.x == CGFloat(-280), rangeOfBall.contains(Int(ballYPosition.y))  {
            print("YES")
            numberOfBalls = numberOfBalls + balls.countOfBalls
        }
    }
    
    func getSun() {
        let rangeOfSun = 200...(300)
        if sun.coordinates.x == CGFloat(-340), rangeOfSun.contains(Int(ballYPosition.y))  {
            numberOfSuns = numberOfSuns + 1
            UserDefaultsManager().addSun()
        }
    }
    
    func secondElementExists(at point: CGPoint) -> Bool {
        elements2.contains { element in
            let testElemnt = element
            let first = element.coordinates.y - 1
            let second = element.coordinates.y + 1
            let xRange = CGFloat(-600.0)...CGFloat(-580.0)
            var yRange = CGFloat(80.0)...CGFloat(200.0)
            if first > second {
                yRange = second...first
                if xRange.contains(point.x), yRange.contains(point.y) {
                    elements2[testElemnt.indexPoint] = Element(name: 0, indexPoint: testElemnt.indexPoint, coordinates: CGPoint(x: 1000, y: 1000))
                }
            } else {
                yRange = first...second
                if xRange.contains(point.x), yRange.contains(point.y) {
                    if numberOfBalls >= element.name {
                        elements2[testElemnt.indexPoint] = Element(name: 0, indexPoint: testElemnt.indexPoint, coordinates: CGPoint(x: 1000, y: 1000))
                    } else {
                        valueWinOrLose = 2
                        isLevelFailed = true
                        timer?.invalidate()
                    }
                }
            }
            return element.coordinates == point
        }
    }
    
    func elementExists(at point: CGPoint) -> Bool {
        elements.contains { element in
            let testElemnt = element
            let first = element.coordinates.y - 1
            let second = element.coordinates.y + 1
            let xRange = CGFloat(-240.0)...CGFloat(-220.0)
            var yRange = CGFloat(80.0)...CGFloat(200.0)
            finishImage.coordinates = CGPoint(x: position.x, y: 300)
            balls.coordinates = CGPoint(x: position.x, y: -100)
            sun.coordinates = CGPoint(x: position.x, y: -50)
            if first > second {
                yRange = second...first
                if xRange.contains(point.x), yRange.contains(point.y) {
                    elements[testElemnt.indexPoint] = Element(name: 0, indexPoint: testElemnt.indexPoint, coordinates: CGPoint(x: 1000, y: 1000))
                }
            } else {
                yRange = first...second
                if xRange.contains(point.x), yRange.contains(point.y) {
                    if numberOfBalls >= element.name {
                        elements[testElemnt.indexPoint] = Element(name: 0, indexPoint: testElemnt.indexPoint, coordinates: CGPoint(x: 1000, y: 1000))
                    } else {
                        valueWinOrLose = 2
                        isLevelFailed = true
                        timer?.invalidate()
                    }
                }
            }
            return element.coordinates == point
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Spacer()
                    VStack {
                        ForEach(0..<6, id: \.self) { index in
                            Text("\(elements[index].name)")
                                .frame(minWidth: 30, maxWidth: 70, minHeight: 30, maxHeight: 70)
                                .background(.blue)
                                .foregroundColor(.white)
                                .font(.custom("Sequel-Regular", size: 20).bold())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(lineWidth: 2)
                                }
                                .position(x: position.x, y: elements[index].coordinates.y)
                                .frame(minWidth: 60, maxWidth: 70, minHeight: 20, maxHeight: 70)
                        }
                    }
                    .offset(x: 220, y: 63)
                    .padding(.horizontal, 50)
                    
                    
                    Spacer()
                    
                    
                }
                
                VStack {
                    Spacer()
                    VStack {
                        ForEach(0..<6, id: \.self) { index in
                            Text("\(elements2[index].name)")
                                .frame(minWidth: 30, maxWidth: 70, minHeight: 30, maxHeight: 70)
                                .background(.blue)
                                .foregroundColor(.white)
                                .font(.custom("Sequel-Regular", size: 20).bold())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(lineWidth: 2)
                                }
                                .position(x: position.x, y: elements2[index].coordinates.y)
                                .frame(minWidth: 60, maxWidth: 70, minHeight: 20, maxHeight: 70)
                        }
                    }
                    .offset(x: 450, y: 63)
                    .padding(.horizontal, 50)
                    
                    
                    Spacer()
                    
                    
                }
                
                VStack {
                    VStack {
                        Image(finishImage.imageName)
                            .resizable()
                            .frame(width: 50, height: 530)
                            .position(finishImage.coordinates)
                        
                    }
                    
                    .offset(x: 550, y: -25)
                }
                
                Text("\(balls.countOfBalls)")
                    .padding()
                    .background(.white)
                    .cornerRadius(5 )
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                    }
                    .position(x: balls.coordinates.x, y: position.y + 100)
                    .frame(width: 50, height: 50)
                    
                
                Image(systemName: sun.imageName)
                    .resizable()
                    .foregroundColor(.yellow)
                    .position(x: sun.coordinates.x + 50 , y: position.y)
                    .frame(width: 50, height: 50)
                    .padding(-30)
                    .onAppear {
                        timer = Timer.scheduledTimer(withTimeInterval: 0.010, repeats: true) { _ in
                            position = CGPoint(x: position.x - 1, y: position.y)
                            let pointToCheck = CGPoint(x: Int(position.x) - 1, y: Int(ballYPosition.y / 20))
                            
                            let _ = elementExists(at: pointToCheck)
                            let _ = secondElementExists(at: pointToCheck)
                            getBalls()
                            getSun()
                            getFinish()
                            ballDown()
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isLevelCompleted) {
            LevelBasketView(countWinOrLose: $valueWinOrLose)
        }
        .navigationDestination(isPresented: $isLevelFailed) {
            LevelBasketView(countWinOrLose: $valueWinOrLose)
        }
    }
}
