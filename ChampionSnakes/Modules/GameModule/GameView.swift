import SwiftUI

struct GameView: View {
    @State var value: Double = 0.5
    @State var ballXPosition: Double = 0.0
    @State var ballYPosition: Double = 120.0
    @State private var offset: CGFloat = 0
    @State var numberOfBalls = 1
    @State var numberOfSuns = UserDefaultsManager.defaults.object(forKey: Keys.sunCount.rawValue) as? Int ?? 0
    @State var isLevelCompleted = false
    @State var isLevelFailed = false
    @State var isPause = false
    @State var backgroundColorOfImage = Color.green
    @State var timer: Timer?
    
    func buttonAction() {
        isPause = true
        timer?.invalidate()
    }
    var body: some View {
        ZStack {
            Image("footballBackground")
                .resizable()
                .ignoresSafeArea()
            VStack {
                VStack {
                    ZStack {
                        VStack {
                            MovingNumbers(numberOfBalls: $numberOfBalls, numberOfSuns: $numberOfSuns, offset: $offset, isLevelCompleted: $isLevelCompleted, ballXPosition: $ballXPosition, ballYPosition: $ballYPosition, isLevelFailed: $isLevelFailed, timer: $timer)
                        }
                        
                        HStack {
                            ButtonView(backgroundColorOfImage: $backgroundColorOfImage, imageForButton: "pause", action: buttonAction)
                            Spacer()
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
                        }
                        .offset(y: -180)
                        .padding()
                    }
                }
                
                ZStack {
                    ForEach(0..<numberOfBalls, id: \.self) { index in
                        Image("ballSocker")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .offset(y: CGFloat(-index * 15))
                    }
                }
                .offset(x: ballXPosition, y: -60)
                
                CustomSlider(value: $value, ballXPosition: $ballXPosition)
                    .padding()
            }
            .navigationDestination(isPresented: $isPause) {
                PauseView(colorOfBack: $backgroundColorOfImage)
            }
        }
        .onAppear() {
            numberOfSuns = UserDefaultsManager.defaults.object(forKey: Keys.sunCount.rawValue) as? Int ?? 0
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameView()
}

struct Element {
    let name: Int
    let indexPoint: Int
    let coordinates: CGPoint
}

struct FinishModelw {
    let imageName: String
    var coordinates: CGPoint
}

struct AddBalls {
    let countOfBalls: Int
    var coordinates: CGPoint
}

struct Sun {
    let imageName: String
    var coordinates: CGPoint
}

struct MovingNumbers: View {
    @Binding var numberOfBalls: Int
    @Binding var numberOfSuns: Int
    @Binding var offset: CGFloat
    @Binding var isLevelCompleted: Bool
    @Binding var ballXPosition: Double
    @Binding var ballYPosition: Double
    @Binding var isLevelFailed: Bool
    @State var valueWinOrLose = 0
    @Binding var timer: Timer?
    @State private var position: CGPoint = CGPoint(x: 0, y: 0)
    @State private var position2: CGPoint = CGPoint(x: 0, y: 0)
    @State var finishImage = FinishModelw(imageName: "finish", coordinates: CGPoint(x: 0, y: 0))
    
    @State var balls =
    AddBalls(countOfBalls: 3, coordinates: CGPoint(x: 50, y: 320))
    
    @State var sun =
    Sun(imageName: "sun.min.fill", coordinates: CGPoint(x: -50, y: 320))
    
    
    @State var elements = [
        Element(name: 1, indexPoint: 0,  coordinates: CGPoint(x: -115 / 10, y: 420)),
        Element(name: 2, indexPoint: 1,  coordinates: CGPoint(x: -81 / 10, y: 420)),
        Element(name: 3, indexPoint: 2,  coordinates: CGPoint(x: -22 / 10, y: 420)),
        Element(name: 4, indexPoint: 3,  coordinates: CGPoint(x: 33 / 10 , y: 420)),
        Element(name: 5, indexPoint: 4,  coordinates: CGPoint(x: 86 / 10, y: 420)),
        Element(name: 6, indexPoint: 5,  coordinates: CGPoint(x: 116 / 10, y: 420))
    ]
    
    @State var elements2 = [
        Element(name: 1, indexPoint: 0,  coordinates: CGPoint(x: -115 / 10, y: 420)),
        Element(name: 1, indexPoint: 1,  coordinates: CGPoint(x: -81 / 10, y: 420)),
        Element(name: 1, indexPoint: 2,  coordinates: CGPoint(x: -22 / 10, y: 420)),
        Element(name: 1, indexPoint: 3,  coordinates: CGPoint(x: 33 / 10 , y: 420)),
        Element(name: 1, indexPoint: 4,  coordinates: CGPoint(x: 86 / 10, y: 420)),
        Element(name: 1, indexPoint: 5,  coordinates: CGPoint(x: 116 / 10, y: 420))
    ]
    
    func getFinish() {
        if finishImage.coordinates.y == CGFloat(800) {
            isLevelCompleted = true
            valueWinOrLose = 1
            UserDefaultsManager().levelCompleted()
            timer?.invalidate()
        }
    }
    
    func getBalls() {
        let rangeOfBall = 20...34
        if balls.coordinates.y == CGFloat(380), rangeOfBall.contains(Int(ballXPosition))  {
            numberOfBalls = numberOfBalls + balls.countOfBalls
        }
    }
    
    func getSun() {
        let rangeOfSun = -75...(-25)
        if sun.coordinates.y == CGFloat(270), rangeOfSun.contains(Int(ballXPosition))  {
            numberOfSuns = numberOfSuns + 1
            UserDefaultsManager().addSun()
        }
    }
    
    func secondElementExists(at point: CGPoint) -> Bool {
        elements2.contains { element in
            let testElemnt = element
            let first = element.coordinates.x - 1
            let second = element.coordinates.x + 1
            var xRange = CGFloat(0.0)...CGFloat(1.0)
            var yRange = CGFloat(400.0)...CGFloat(450.0)
            if first > second {
                xRange = second...first
                yRange = CGFloat(130.0)...CGFloat(200.0)
                if xRange.contains(point.x), yRange.contains(point.y) {
                    elements2[testElemnt.indexPoint] = Element(name: 0, indexPoint: testElemnt.indexPoint, coordinates: CGPoint(x: 1000, y: 1000))
                }
            } else {
                xRange = first...second
                yRange = CGFloat(130.0)...CGFloat(200.0)
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
            let first = element.coordinates.x - 1
            let second = element.coordinates.x + 1
            var xRange = CGFloat(0.0)...CGFloat(1.0)
            let yRange = CGFloat(400.0)...CGFloat(450.0)
            finishImage.coordinates = CGPoint(x: 200, y: position.y)
            balls.coordinates = CGPoint(x: 50, y: position.y)
            sun.coordinates = CGPoint(x: -50, y: position.y)
            if first > second {
                xRange = second...first
                if xRange.contains(point.x), yRange.contains(point.y) {
                        elements[testElemnt.indexPoint] = Element(name: 0, indexPoint: testElemnt.indexPoint, coordinates: CGPoint(x: 1000, y: 1000))
                    }
            } else {
                xRange = first...second
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
            VStack {
                VStack {
                    Image(finishImage.imageName)
                        .resizable()
                        .frame(width: 400, height: 50)
                        .position(finishImage.coordinates)
                }
                .offset(x: 0, y: -270)
                
                VStack {
                    HStack {
                        ForEach(0..<6, id: \.self) { index in
                            Text("\(elements[index].name)")
                                .padding()
                                .foregroundColor(.white)
                                .font(.custom("Sequel-Regular", size: 20).bold())
                                .background(.blue)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(lineWidth: 2)
                                }
                                .position(x: elements[index].coordinates.x, y: position.y)
                                .frame(height: 50)
                        }
                    }
                    .offset(x: 15, y: -170)
                    .padding(.horizontal, 50)
                    
                    
                    Text("\(balls.countOfBalls)")
                        .padding()
                        .background(.white)
                        .cornerRadius(5 )
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 2)
                        }
                        .position(x: balls.coordinates.x, y: position.y)
                        .frame(width: 50, height: 50)
                        .offset(y: -120)
                    
                    Image(systemName: sun.imageName)
                        .resizable()
                        .foregroundColor(.yellow)
                        .position(x: sun.coordinates.x, y: position.y)
                        .frame(width: 50, height: 50)
                        .offset(y: -50)
                }
                
                
                VStack {
                    HStack {
                        ForEach(0..<6, id: \.self) { index in
                            Text("\(elements2[index].name)")
                                .padding()
                                .foregroundColor(.white)
                                .font(.custom("Sequel-Regular", size: 20).bold())
                                .background(.blue)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(lineWidth: 2)
                                }
                                .position(x: elements2[index].coordinates.x, y: position.y)
                        }
                    }
                    .offset(x: 15)
                    .padding(.horizontal, 50)
                }
            }
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.010, repeats: true) { _ in
                    position = CGPoint(x: position.x, y: position.y + 1)
                    let pointToCheck = CGPoint(x: Int(ballXPosition / 10), y: Int(position.y) + 1)
                    let _ = elementExists(at: pointToCheck)
                    let _ = secondElementExists(at: pointToCheck)
                    getBalls()
                    getSun()
                    getFinish()
                }
            }
        }
        .navigationDestination(isPresented: $isLevelCompleted) {
            LevelView(countWinOrLose: $valueWinOrLose)
        }
        
        .navigationDestination(isPresented: $isLevelFailed) {
            LevelView(countWinOrLose: $valueWinOrLose)
        }
    }
}

struct CustomSlider: View {
    @Binding var value: Double
    @Binding var ballXPosition: Double
    
    func updateValue(with geasture: DragGesture.Value, in geometry: GeometryProxy) {
        let newValue = geasture.location.x / geometry.size.width
        value = min(max(Double(newValue), 0.03), 1)
        ballXPosition = CGFloat(value) * geometry.size.width - 123
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: 40)
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(lineWidth: 20)
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width , height: 55)
                }
                ZStack {
                    Circle()
                        .foregroundColor(.green)
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(#colorLiteral(red: 43/255, green: 110/255, blue: 42/255, alpha: 1)), lineWidth: 2)
                        }
                }
                .offset(x: CGFloat(value) * geometry.size.width - 30, y: -2)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { geasture in
                            updateValue(with: geasture, in: geometry)
                        }
                )
            }
        }
        
        .frame(height: 40)
        .padding(.horizontal, 40)
        .padding()
    }
}

struct CountOfSunView: View {
    var count: Int
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10) {
                Text("\(count)")
                    .font(.custom("Sequel-Regular", size: 42).bold())
                    .foregroundColor(.white)
                    .offset(y: -3)
                
                Image(systemName: "sun.min.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.yellow)
                    .frame(width: 35, height: 55)
            }
            .frame(width: 185, height: 88)
            .background((Color(#colorLiteral(red: 16/255, green: 117/255, blue: 189/255, alpha: 1))))
            .cornerRadius(20)
            .offset(y: -17)
        }
    }
}


